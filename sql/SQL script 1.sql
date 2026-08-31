-- Créer une base de données pour notre couche analytique Healthcare

CREATE DATABASE healthcare_gold;

-- Créer une vue SQL sur la table Delta fact_admission.
-- Les données restent physiquement dans ADLS.

CREATE OR ALTER VIEW dbo.vw_fact_admission
AS

SELECT *
FROM OPENROWSET(
    BULK 'https://adlgenstorage.dfs.core.windows.net/healthcare/Gold/fact_admission/',
    FORMAT = 'DELTA'
) AS fact;

-- Tester la vue

-- Vue Patient
CREATE OR ALTER VIEW dbo.vw_dim_patient
AS
SELECT *
FROM OPENROWSET(
    BULK 'https://adlgenstorage.dfs.core.windows.net/healthcare/Gold/dim_patient/',
    FORMAT = 'DELTA'
) AS patient;

-- Vue Hospital
CREATE OR ALTER VIEW dbo.vw_dim_hospital
AS
SELECT *
FROM OPENROWSET(
    BULK 'https://adlgenstorage.dfs.core.windows.net/healthcare/Gold/dim_hospital/',
    FORMAT = 'DELTA'
) AS hospital;

-- Vue Medical Condition
CREATE OR ALTER VIEW dbo.vw_dim_condition
AS
SELECT *
FROM OPENROWSET(
    BULK 'https://adlgenstorage.dfs.core.windows.net/healthcare/Gold/dim_condition/',
    FORMAT = 'DELTA'
) AS condition;

-- Vue Insurance
CREATE OR ALTER VIEW dbo.vw_dim_insurance
AS
SELECT *
FROM OPENROWSET(
    BULK 'https://adlgenstorage.dfs.core.windows.net/healthcare/Gold/dim_insurance/',
    FORMAT = 'DELTA'
) AS insurance;

-- Contrôle du nombre d'admissions accessibles depuis SQL Serverless
---------------------------------------------------------------------------------------------
SELECT COUNT(*) AS total_admissions
FROM dbo.vw_fact_admission;
-- Relier la table de faits aux dimensions
-- grâce aux clés créées dans notre modèle Gold.
---------------------------------------------------------------------------
SELECT TOP 20
    f.admission_key,
    p.name,
    p.age,
    p.gender,
    h.hospital,
    c.medical_condition,
    i.insurance_provider,
    f.date_of_admission,
    f.discharge_date,
    f.billing_amount,
    f.length_of_stay

FROM dbo.vw_fact_admission f

LEFT JOIN dbo.vw_dim_patient p
    ON f.patient_key = p.patient_key

LEFT JOIN dbo.vw_dim_hospital h
    ON f.hospital_key = h.hospital_key

LEFT JOIN dbo.vw_dim_condition c
    ON f.condition_key = c.condition_key

LEFT JOIN dbo.vw_dim_insurance i
    ON f.insurance_key = i.insurance_key;
    -----------------------------------------------------------------------------------
    --nombre total d'admissions
     SELECT
    SUM(billing_amount) AS total_billing
FROM dbo.vw_fact_admission;
-----------------------------------------------------------------------------------
--Montant total facturé
SELECT
    SUM(billing_amount) AS total_billing
FROM dbo.vw_fact_admission;
---------------------------------------------------------------------------------------------------
---Durée moyenne des séjours :
SELECT
    AVG(CAST(length_of_stay AS FLOAT)) AS average_length_of_stay
FROM dbo.vw_fact_admission
WHERE length_of_stay IS NOT NULL;
