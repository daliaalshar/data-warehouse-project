-- ============================================================
-- DS2202 – Data Integration and Warehousing
-- Lab 6: Data Warehouse – CREATE TABLE Statements
-- Schema: Tourism Data Mart (Star Schema)
-- ============================================================
CREATE DATABASE IF NOT EXISTS dw_project;
USE  dw_project;
-- ------------------------------------------------------------
-- 1. Dimension Table: DIM_DATE
-- ------------------------------------------------------------
CREATE TABLE DIM_DATE (
    date_key    INT          PRIMARY KEY,
    year        INT          NOT NULL,
    month       INT          NOT NULL,   -- 1–12
    quarter     INT          NOT NULL,   -- 1–4
    season      VARCHAR(20)  NOT NULL    -- Winter / Spring / Summer / Fall
);

-- ------------------------------------------------------------
-- 2. Dimension Table: DIM_LOCATION
-- ------------------------------------------------------------
CREATE TABLE DIM_LOCATION (
    location_key    INT          PRIMARY KEY,
    province_name   VARCHAR(100) NOT NULL,
    region          VARCHAR(100),
    country         VARCHAR(100) NOT NULL DEFAULT 'Saudi Arabia',
    avg_temp        DECIMAL(5,2),
    location_type   VARCHAR(20)  NOT NULL 
);

-- ------------------------------------------------------------
-- 3. Dimension Table: DIM_PURPOSE
-- ------------------------------------------------------------
CREATE TABLE DIM_PURPOSE (
    purpose_key     INT          PRIMARY KEY,
    purpose_name    VARCHAR(100) NOT NULL,
    category        VARCHAR(50),
    tourist_type    VARCHAR(50),
    trip_type       VARCHAR(50)
);

-- ------------------------------------------------------------
-- 4. Fact Table: FACT_TOURISM
-- ------------------------------------------------------------
CREATE TABLE FACT_TOURISM (
    fact_id         INT            PRIMARY KEY,
    date_key        INT            NOT NULL,
    location_key    INT            NOT NULL,
    purpose_key     INT            NOT NULL,
    trips           DECIMAL(10,2)  NOT NULL,
    spend_SAR       DECIMAL(15,2),
    nights          DECIMAL(12,2),
    avg_temp        DECIMAL(5,2),
    visitors        INT,
    FOREIGN KEY (date_key)     REFERENCES DIM_DATE(date_key),
    FOREIGN KEY (location_key) REFERENCES DIM_LOCATION(location_key),
    FOREIGN KEY (purpose_key)  REFERENCES DIM_PURPOSE(purpose_key)
);
-- ============================================================

-- LOAD: DIM_DATE  (8 rows)
-- Source: year & month columns in tourism_with_temps.csv
-- Covers 2 representative periods per year for 2022
-- ------------------------------------------------------------
INSERT INTO DIM_DATE (date_key, year, month, quarter, season) VALUES
(1, 2022, 1,  1, 'Winter'),
(2, 2022, 4,  2, 'Spring'),
(3, 2022, 7,  3, 'Summer'),
(4, 2022, 10, 4, 'Fall'),
(5, 2023, 1,  1, 'Winter'),
(6, 2023, 4,  2, 'Spring'),
(7, 2023, 7,  3, 'Summer'),
(8, 2023, 10, 4, 'Fall');

-- ------------------------------------------------------------
-- LOAD: DIM_LOCATION  (8 rows)
-- Source: destinationProvinceNameEn in tourism_with_temps.csv
--         + inbound country from Top_ten_inbound_source_markets_CSV.csv
-- avg_temp derived from destination_temp column
-- ------------------------------------------------------------
INSERT INTO DIM_LOCATION (location_key, province_name, region, country, avg_temp, location_type) VALUES
(1, 'Albaha',           'Southern',  'Saudi Arabia', 19.61, 'Domestic'),
(2, 'Aseer',            'Southern',  'Saudi Arabia', 18.48, 'Domestic'),
(3, 'Makkah',           'Western',   'Saudi Arabia', 20.46, 'Domestic'),
(4, 'Madinah',          'Western',   'Saudi Arabia', 15.31, 'Domestic'),
(5, 'Riyadh',           'Central',   'Saudi Arabia', 13.36, 'Domestic'),
(6, 'Eastern',          'Eastern',   'Saudi Arabia', 14.20, 'Domestic'),
(7, 'Hail',             'Northern',  'Saudi Arabia',  9.64, 'Domestic'),
(8, 'Kuwait',           'Gulf',      'Kuwait',        NULL, 'Inbound');

-- ------------------------------------------------------------
-- LOAD: DIM_PURPOSE  (5 rows)
-- Source: visitPurposeEn column in tourism_with_temps.csv
-- ------------------------------------------------------------
INSERT INTO DIM_PURPOSE (purpose_key, purpose_name, category, tourist_type, trip_type) VALUES
(1, 'Leisure',   'Recreation',    'Domestic',      'Overnight'),
(2, 'Business',  'Work',          'Domestic',      'Day trip'),
(3, 'VFR',       'Social',        'Domestic',      'Overnight'),
(4, 'Religious', 'Pilgrimage',    'International', 'Overnight'),
(5, 'Other',     'Miscellaneous', 'Domestic',      'Day trip');

-- ------------------------------------------------------------
-- LOAD: FACT_TOURISM  (10 rows)
-- Source: tourism_with_temps.csv – month=7, year=2022 (cleaned subset)
-- Each row = one province-origin-purpose combination
-- trips, spendSAR, nights values taken directly from source
-- avg_temp = destination_temp from source
-- visitors approximated from trips (rounded integer)
-- ------------------------------------------------------------
INSERT INTO FACT_TOURISM (fact_id, date_key, location_key, purpose_key, trips, spend_SAR, nights, avg_temp, visitors) VALUES
(1,  3, 1, 2,    18.00,     54521.01,     55.88, 27.71,    18),
(2,  3, 1, 1,  1162.00,   2393194.13,   6074.95, 27.71,  1162),
(3,  3, 1, 3,   596.00,   2361746.31,   3589.08, 27.71,   596),
(4,  3, 1, 2,  4369.00,   7498559.97,  14563.34, 27.71,  4369),
(5,  3, 1, 1, 12673.00,  12474348.77,  84241.79, 27.71, 12673),
(6,  3, 1, 5,   888.00,   1310778.84,   2687.05, 27.71,   888),
(7,  3, 1, 3,  1956.00,   7306455.34,  10663.92, 27.71,  1956),
(8,  3, 2, 1,  5971.00,   7068000.00,  39079.00, 18.48,  5971),
(9,  3, 3, 4,  7026.00,   3705828.52,  15484.13, 20.46,  7026),
(10, 3, 5, 2,   768.00,   3400824.00,   1549.24, 13.36,   768);

