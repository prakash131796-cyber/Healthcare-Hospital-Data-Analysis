-- Healthcare & Hospital Data Analysis
-- Database: HospitalDB
-- Table: Hospital_Data
-- SQL dialect: MySQL

CREATE DATABASE IF NOT EXISTS HospitalDB;

USE HospitalDB;

CREATE TABLE IF NOT EXISTS Hospital_Data (
    Patient_ID INT PRIMARY KEY,
    Patient_Name VARCHAR(100),
    Age INT,
    Gender VARCHAR(20),
    Blood_Group VARCHAR(10),
    City VARCHAR(50),
    Admission_Date DATE,
    Discharge_Date DATE,
    Department VARCHAR(50),
    Diagnosis VARCHAR(100),
    Doctor VARCHAR(100),
    Treatment VARCHAR(100),
    Room_Type VARCHAR(50),
    Stay_Days INT,
    Total_Bill DECIMAL(12,2),
    Insurance VARCHAR(50),
    Payment_Mode VARCHAR(50),
    Patient_Satisfaction DECIMAL(3,2),
    Calculated_Stay_Days INT
);

-- View all hospital records
SELECT * FROM Hospital_Data;

-- Total unique patients
SELECT COUNT(DISTINCT Patient_ID) AS Total_Patients
FROM Hospital_Data;

-- Total hospital revenue
SELECT SUM(Total_Bill) AS Total_Revenue
FROM Hospital_Data;

-- Average hospital bill
SELECT ROUND(AVG(Total_Bill), 2) AS Average_Bill
FROM Hospital_Data;

-- Department-wise performance and revenue
SELECT
    Department,
    COUNT(*) AS Patients,
    SUM(Total_Bill) AS Revenue,
    ROUND(AVG(Total_Bill), 2) AS Average_Bill,
    ROUND(AVG(Stay_Days), 2) AS Average_Stay,
    ROUND(AVG(Patient_Satisfaction), 2) AS Satisfaction
FROM Hospital_Data
GROUP BY Department
ORDER BY Revenue DESC;

-- Top 10 most common diagnoses
SELECT
    Diagnosis,
    COUNT(*) AS Patient_Count
FROM Hospital_Data
GROUP BY Diagnosis
ORDER BY Patient_Count DESC
LIMIT 10;

-- Doctor-wise patient count and revenue
SELECT
    Doctor,
    COUNT(*) AS Patients,
    SUM(Total_Bill) AS Revenue,
    ROUND(AVG(Total_Bill), 2) AS Average_Bill
FROM Hospital_Data
GROUP BY Doctor
ORDER BY Revenue DESC;

-- Payment mode analysis
SELECT
    Payment_Mode,
    COUNT(*) AS Transactions,
    SUM(Total_Bill) AS Revenue
FROM Hospital_Data
GROUP BY Payment_Mode
ORDER BY Revenue DESC;

-- Insurance-wise patient and billing analysis
SELECT
    Insurance,
    COUNT(*) AS Patients,
    SUM(Total_Bill) AS Revenue,
    ROUND(AVG(Total_Bill), 2) AS Average_Bill
FROM Hospital_Data
GROUP BY Insurance
ORDER BY Revenue DESC;

-- Monthly patient admission trends
SELECT
    YEAR(Admission_Date) AS Year,
    MONTH(Admission_Date) AS Month,
    COUNT(*) AS Patients
FROM Hospital_Data
WHERE Admission_Date IS NOT NULL
GROUP BY YEAR(Admission_Date), MONTH(Admission_Date)
ORDER BY Year, Month;

-- Top 10 highest-billing patients
SELECT
    Patient_ID,
    Patient_Name,
    Department,
    Diagnosis,
    Total_Bill
FROM Hospital_Data
ORDER BY Total_Bill DESC
LIMIT 10;
