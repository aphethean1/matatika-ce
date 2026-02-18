-- DuckLake Initialization Script
-- This script attaches to the ducklake_catalog PostgreSQL database using DuckLake extension

-- Install and load the ducklake extension
INSTALL ducklake;
LOAD ducklake;

-- Attach to the PostgreSQL catalog database using DuckLake
ATTACH 'ducklake:postgres:host=ducklake_catalog port=5432 user=ducklake_user password=ducklake_password dbname=ducklake_catalog' AS ducklake_catalog (DATA_PATH '/workspace/warehouse/data/ducklake_catalog');

-- Create a sample table in the DuckLake catalog
-- Note: DuckLake does not support PRIMARY KEY constraints
CREATE TABLE IF NOT EXISTS ducklake_catalog.main.sample_data (
    id INTEGER,
    name VARCHAR(100),
    description TEXT,
    created_date DATE,
    value DECIMAL(10,2)
);

-- Insert sample entries if the table is empty
INSERT INTO ducklake_catalog.main.sample_data (id, name, description, created_date, value)
SELECT * FROM (
    VALUES
        (1, 'Sample Entry 1', 'This is the first sample entry', '2026-01-15', 100.50),
        (2, 'Sample Entry 2', 'This is the second sample entry', '2026-01-16', 250.75),
        (3, 'Sample Entry 3', 'This is the third sample entry', '2026-01-17', 175.25),
        (4, 'Sample Entry 4', 'This is the fourth sample entry', '2026-01-18', 300.00),
        (5, 'Sample Entry 5', 'This is the fifth sample entry', '2026-01-19', 150.90)
) AS t(id, name, description, created_date, value)
WHERE NOT EXISTS (
    SELECT 1 FROM ducklake_catalog.main.sample_data
);

-- Verify the data
SELECT 'DuckLake initialization completed. Sample data created in PostgreSQL catalog:' AS message;
SELECT * FROM ducklake_catalog.main.sample_data;
