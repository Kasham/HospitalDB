USE master;
GO
--CREATING THE DATABASE
CREATE DATABASE HospitalDB;

--CREATING THE TABLES IN THE DATABASE
USE HospitalDB;
GO

-- CREATING PATIENTS TABLE
CREATE TABLE Patients (
PatientID INT  IDENTITY(1,1)  NOT NULL PRIMARY KEY,
FullName  NVARCHAR(100) NOT NULL,
Address  NVARCHAR(255) NOT NULL,
DateOfBirth  DATE NOT NULL,
Insurance NVARCHAR(100) NOT NULL,
Username NVARCHAR(100) UNIQUE NOT NULL,
Password NVARCHAR (225) NOT NULL CHECK (
    LEN(Password) >= 8 AND 
    Password LIKE '%[A-Z]%' AND 
    Password LIKE '%[^a-zA-Z0-9]%'),
Email NVARCHAR (100),
PhoneNumber NVARCHAR(20),
DateLeft DATE
 )

   --CREATING DEPARTMENTS TABLE
CREATE TABLE Departments(
DepartmentID INT IDENTITY(200,10) NOT NULL PRIMARY KEY,
DepartmentName NVARCHAR(100),
)

--CREATING DOCTORS TABLE
CREATE TABLE Doctors(
DoctorID INT IDENTITY(100,10) NOT NULL PRIMARY KEY,
FullName  NVARCHAR(100) NOT NULL,
Specialization NVARCHAR(100) NOT NULL,
DepartmentID INT FOREIGN KEY REFERENCES Departments(DepartmentID),
DrAvailability NVARCHAR (20) CHECK( DrAvailability IN('Available', 'Unavailable'))
)

--CREATING PAST APPOINTMENT TABLE
CREATE TABLE PastAppointments(
PastAppointmentID INT IDENTITY(101,1) PRIMARY KEY,
AppointmentDate DATE,
AppointmentTime TIME,
Feedback NVARCHAR(MAX),
AppointmentStatus NVARCHAR(20) CHECK (AppointmentStatus IN('Completed')),
)

--CREATING APPOINTMENT TABLE
CREATE TABLE Appointments(
AppointmentID INT IDENTITY(1001,1) PRIMARY KEY,
PatientID INT FOREIGN KEY REFERENCES Patients(PatientID),
DoctorID INT FOREIGN KEY REFERENCES Doctors(DoctorID),
AppointmentDate DATE,
AppointmentTime TIME,
DepartmentID INT FOREIGN KEY REFERENCES Departments(DepartmentID),
AppointmentStatus NVARCHAR (20) CHECK (AppointmentStatus IN('Pending', 'Cancelled', 'Completed')),
)

--CREATING DIAGNOSIS TABLE
CREATE TABLE Diagnosis (
DiagnosisID NVARCHAR PRIMARY KEY,
DrDiagnosis NVARCHAR(MAX),
PatientID INT FOREIGN KEY REFERENCES Patients(PatientID),
DoctorID INT FOREIGN KEY REFERENCES Doctors(DoctorID),
)

--CREATING MEDICINE TABLE
CREATE TABLE Medicines (
    MedicineID INT PRIMARY KEY,
    MedicineName NVARCHAR(100),
	PrescriptionDate  DATE,
)

--CREATING ALLERGIES TABLE
CREATE TABLE Allergies (
    AllergyID INT PRIMARY KEY,
    AllergyName NVARCHAR(100)
)
--CREATING MEDICAL RECORDS TABLE
CREATE TABLE MedicalRecords(
MedicalRecordID INT IDENTITY(1201,20) PRIMARY KEY,
PatientID INT FOREIGN KEY REFERENCES Patients(PatientID),
DoctorID INT FOREIGN KEY REFERENCES Doctors(DoctorID),
AllergyID INT FOREIGN KEY REFERENCES Allergies(AllergyID),
MedicineID INT FOREIGN KEY REFERENCES Medicines(MedicineID),
DiagnosisID NVARCHAR FOREIGN KEY REFERENCES Diagnosis(DiagnosisID),
PastAppointmentID INT  FOREIGN KEY REFERENCES PastAppointments(PastAppointmentID),
)

-- POPULATING  ALL TABLES

--Patient Table
INSERT INTO Patients (FullName, Address, DateOfBirth, Insurance, Username, Password, Email, PhoneNumber)
VALUES 
('Jake Luka', '1245 Main St', '1976-05-15', 'ABC Insurance', 'jakeluk', 'P@s12sw0kd', 'jakeluk@example.com', '123-490-7890'),
('Janet Ham', '4566 Oak St', '1977-09-20', 'XYZ Insurance', 'jenetham', 'fi7jeSth/', 'jane.smith@example.com', '632-654-3210'),
('John Doe', '123 Main St', '1980-05-15', 'ABC Insurance', 'johndoe', 'P@s12sw0rd', 'john.doe@example.com', '123-456-7890'),
('Jane Smith', '456 Oak St', '1990-09-20', 'XYZ Insurance', 'janesmith', 'Si7deSth/', 'jane.smith@example.com', '987-654-3210'),
('Michael Johnson', '789 Elm St', '1975-02-10', 'DEF Insurance', 'michaelj', 'fF0\ONqNY', 'michael.j@example.com', '456-789-0123'),
('Sarah Williams', '101 Pine St', '1988-11-30', 'GHI Insurance', 'sarahw', 'SecretPass1!23', 'sarah.w@example.com', '789-012-3456'),
('David Brown', '202 Maple St', '1983-07-25', 'JKL Insurance', 'davidb', 'gE7&GdtI3', 'david.b@example.com', '012-345-6789'),
('Emily Wilson', '303 Cedar St', '1995-04-18', 'MNO Insurance', 'emilyw', 'ProtectedPa#ss123', 'emily.w@example.com', '234-567-8901'),
('James Taylor', '404 Birch St', '1998-12-05', 'PQR Insurance', 'jamest', 'wA7,aaOA9e', 'james.t@example.com', '345-678-9012'),
('Jessica Lee', '505 Walnut St', '1984-08-22', 'STU Insurance', 'jessical', 'HiddenPass1%23', 'jessica.l@example.com', '456-789-0123'),
('Christopher Hall', '606 Cherry St', '1992-03-15', 'VWX Insurance', 'christopherh', ' hT9$Yy}8I{RODjaS', 'christopher.h@example.com', '567-890-1234'),
('Amanda Garcia', '707 Orange St', '1978-10-08', 'YZA Insurance', 'amandag', 'StrongPas*s987', 'amanda.g@example.com', '678-901-2345'),
('Matthew Martinez', '808 Lemon St', '1982-06-20', 'BCD Insurance', 'matthewm', 'rO2.(_J\0oA(', 'matthew.m@example.com', '789-012-3456'),
('Nicole Rodriguez', '909 Grape St', '1993-01-25', 'EFG Insurance', 'nicoler', 'Protecte\987Pass', 'nicole.r@example.com', '890-123-4567'),
('Daniel Lopez', '1010 Olive St', '1973-09-15', 'HIJ Insurance', 'daniell', 'tI1!X2`sNVi', 'daniel.l@example.com', '901-234-5678'),
('Ashley Hernandez', '1111 Peach St', '1984-05-10', 'KLM Insurance', 'ashleyh', 'Hidden98@Pass', 'ashley.h@example.com', '012-345-6789'),
('Andrew Gonzalez', '1212 Plum St', '1996-02-28', 'NOP Insurance', 'andrewg', 'pT5}0HiV??JMHJf', 'andrew.g@example.com', '123-456-7890'),
('Megan Perez', '1313 Cherry St', '1976-07-12', 'QRS Insurance', 'meganp', 'hF8\pRwaYhnKWmI', 'megan.p@example.com', '234-567-8901'),
('Ryan Torres', '1414 Apple St', '1989-03-05', 'TUV Insurance', 'ryant', 'Secure7@9Pass', 'ryan.t@example.com', '345-678-9012'),
('Taylor Ramirez', '1515 Banana St', '1981-11-18', 'WXY Insurance', 'taylorr', 'wV8/ZXQ0C2PNauS7', 'taylor.r@example.com', '456-789-0123'),
('Lauren Flores', '1616 Mango St', '1994-08-08', 'ZAB Insurance', 'laurenf', 'Safe789^Pass', 'lauren.f@example.com', '567-890-1234'),
('Justin Washington', '1717 Avocado St', '1960-04-30', 'BCD Insurance', 'justinw', 'P@ssw02rd', 'justin.w@example.com', '678-901-2345');

select * from Patients

--Departments Table
INSERT INTO Departments ( DepartmentName)
VALUES 
('Pediatrics'),
('Orthopedics'),
('Ophthalmology'),
('Neurology'),
('Dermatology'),
('Oncology'),
('Gynecology'),
('Urology'),
('Pulmonology'),
('Nephrology'),
('Rheumatology'),
('Otolaryngology'),
('Hematology'),
('Allergy and Immunology'),
('Gastroenterology');

--Docotors Table

INSERT INTO Doctors (FullName, Specialization, DepartmentID, DrAvailability)
VALUES 
('Dr. Smith', 'Gynecologist', 260, 'Available'),
('Dr. Johnson', 'Pediatrician', 200, 'Available'),
('Dr. Williams', 'Neurologist', 230, 'Available'),
('Dr. Brown', 'Orthopedic Surgeon', 210, 'Available'),
('Dr. Taylor', 'Dermatologist', 240, 'Available'),
('Dr. Martinez', 'Ophthalmologist', 220, 'Available'),
('Dr. Lee', 'Pediatrician', 200, 'Available'),
('Dr. Rodriguez', 'Oncologist', 250, 'Available'),
('Dr. Lopez', 'Gynecologist', 260, 'Available'),
('Dr. Garcia', 'Urologist', 270, 'Available'),
('Dr. Hernandez', 'Oncologist', 250, 'Available'),
('Dr. Gonzalez', 'Pulmonologist', 280, 'Available'),
('Dr. Perez', 'Nephrologist', 290, 'Available'),
('Dr. Torres', 'Rheumatologist', 300, 'Available'),
('Dr. Ramirez', 'Otolaryngologist', 310, 'Available'),
('Dr. Flores', 'Hematologist', 320, 'Available'),
('Dr. Washington', 'Allergist', 330, 'Available'),
('Dr. Nguyen', 'Gastroenterologist', 340, 'Available'),
('Dr. Patel', 'Gastroenterologist', 340, 'Available'),
('Dr. Kim', 'Hematologist', 320, 'Available');

SELECT * FROM Doctors

--Appointment table
INSERT INTO Appointments( PatientID, DoctorID, AppointmentDate, AppointmentTime, DepartmentID, AppointmentStatus)
VALUES 
( 21, 100, '2024-04-24', '10:00:00', 260, 'Pending'),
( 22, 110, '2024-04-24', '11:00:00', 260, 'Pending'),
( 1, 100, '2024-04-23', '10:00:00', 260, 'Completed'),
( 2, 110, '2024-04-24', '11:00:00', 200, 'Pending'),
( 3, 120, '2024-04-25', '12:00:00', 220, 'Pending'),
( 4, 130, '2024-04-26', '13:00:00', 210, 'Pending'),
( 5, 140, '2024-04-27', '14:00:00', 240, 'Pending'),
( 6, 150, '2024-04-28', '15:00:00', 220, 'Pending'),
( 7, 160, '2024-04-29', '16:00:00', 200, 'Pending'),
( 8, 170, '2024-04-30', '17:00:00', 250, 'Pending'),
( 9, 180, '2024-05-01', '09:00:00', 260, 'Pending'),
( 10, 190, '2024-05-02', '10:00:00', 270, 'Pending'),
( 11, 200, '2024-05-03', '11:00:00', 250, 'Pending'),
( 12, 210, '2024-05-04', '12:00:00', 280, 'Pending'),
( 13, 220, '2024-05-05', '13:00:00', 290, 'Pending'),
( 14, 230, '2024-05-06', '14:00:00', 300, 'Pending'),
( 15, 240, '2024-05-07', '15:00:00', 310, 'Pending');

select * From Appointments
--DIAGNOSIS TABLE
INSERT INTO Diagnosis (DiagnosisID, DrDiagnosis, PatientID, DoctorID)
VALUES 
(1, 'Hypertension', 1, 100),
(2, 'Asthma', 2, 110),
(3, 'Fractured arm', 3, 120),
(4, 'Conjunctivitis', 4, 130),
(5, 'Migraine', 5, 140),
(6, 'Eczema', 19, 150),
(7, 'Cancer', 8, 160),
(8, 'Endometriosis', 18, 170),
(9, 'Urinary tract infection', 9, 180),
(10, 'Pneumonia', 10, 190),
(11, 'Rheumatoid arthritis', 11, 200),
(12, 'Otitis media', 6, 210),
(13, 'Anemia', 7, 220),
(14, 'Food allergy', 14, 230),
(15, 'Gastritis', 20, 240),
(16, 'Cancer', 21, 160),
(17, 'Cancer', 22, 160);


--MEDICINE TABLE
INSERT INTO Medicines (MedicineID, MedicineName, PrescriptionDate)
VALUES 
(1, 'Aspirin', '2024-04-23'),
(2, 'Ventolin', '2024-04-24'),
(3, 'Ibuprofen', '2024-04-25'),
(4, 'Eye Drops', '2024-04-26'),
(5, 'Sumatriptan', '2024-04-27'),
(6, 'Hydrocortisone Cream', '2024-04-28'),
(7, 'Chemotherapy Drugs', '2024-04-29'),
(8, 'Birth Control Pills', '2024-04-30'),
(9, 'Antibiotics', '2024-05-01'),
(10, 'Amoxicillin', '2024-05-02'),
(11, 'Steroids', '2024-05-03'),
(12, 'Ear Drops', '2024-05-04'),
(13, 'Iron Supplements', '2024-05-05'),
(14, 'Antihistamines', '2024-05-06'),
(15, 'Antacids', '2024-05-07');


--ALLERGY TABLE
INSERT INTO Allergies (AllergyID, AllergyName)
VALUES 
(1, 'Peanuts'),
(2, 'Penicillin'),
(3, 'Shellfish'),
(4, 'Eggs'),
(5, 'Milk'),
(6, 'Soy'),
(7, 'Tree nuts'),
(8, 'Wheat'),
(9, 'Fish'),
(10, 'Sesame'),
(11, 'Dust mites'),
(12, 'Pollen'),
(13, 'Animal dander'),
(14, 'Mold'),
(15, 'Insect stings'),
(16, 'NONE');

--PAST APPOINTMENT TABLE
INSERT INTO PastAppointments (AppointmentDate, AppointmentTime, Feedback, AppointmentStatus)
VALUES
('2023-08-20', '08:30:00', 'Doctor was knowledgeable and helpful.', 'Completed'),
('2023-08-15', '12:00:00', 'Great communication from the doctor.', 'Completed'),
('2023-09-10', '13:30:00', 'Pleasant experience.', 'Completed'),
('2023-08-20', '08:30:00', 'Doctor was knowledgeable and helpful.', 'Completed'),
('2023-08-15', '12:00:00', 'Great communication from the doctor.', 'Completed'),
('2023-08-10', '15:15:00', 'Appointment went smoothly.', 'Completed'),
('2023-08-05', '11:30:00', 'Satisfied with the treatment received.', 'Completed'),
('2023-07-28', '09:00:00', 'Doctor was attentive to my concerns.', 'Completed'),
('2023-10-05', '10:00:00', 'Excellent service, highly recommend.', 'Completed'),
('2023-09-28', '09:30:00', 'Good experience overall.', 'Completed'),
('2023-09-20', '11:15:00', 'Satisfied with the treatment.', 'Completed'),
('2023-09-15', '14:45:00', 'Doctor was very informative.', 'Completed'),
('2023-09-10', '13:30:00', 'Pleasant experience.', 'Completed'),
('2023-09-05', '16:00:00', 'Professional and courteous staff.', 'Completed'),
('2023-08-28', '10:45:00', 'Received good care.', 'Completed'),
('2023-08-20', '08:30:00', 'Doctor was knowledgeable and helpful.', 'Completed'),
('2023-08-15', '12:00:00', 'Great communication from the doctor.', 'Completed'),
('2023-08-10', '15:15:00', 'Appointment went smoothly.', 'Completed'),
('2023-08-05', '11:30:00', 'Satisfied with the treatment received.', 'Completed'),
('2023-07-28', '09:00:00', 'Doctor was attentive to my concerns.', 'Completed'),
('2023-07-20', '14:00:00', 'Happy with the outcome.', 'Completed'),
('2023-07-15', '13:45:00', 'Doctor was thorough in examination.', 'Completed'),
('2023-07-10', '10:30:00', 'Received good care and advice.', 'Completed');


SELECT * FROM PastAppointments

--MEDICALRECORDS TABLE
INSERT INTO MedicalRecords (PatientID, DoctorID, AllergyID, MedicineID, DiagnosisID, PastAppointmentID)
VALUES 
(1, 100, 1, 1, 1, 101),
(2, 110, 2, 2, 2, 102),
(3, 120, 3, 3, 3, 103),
(4, 130, 4, 4, 4, 104),
(5, 140, 5, 5, 5, 104),
(6, 150, 6, 6, 6, 106),
(7, 160, 7, 7, 8, 107),
(8, 160, 16, 8, 7, 108),
(9, 180, 9, 9, 9, 109),
(10, 190, 10, 10, 10, 110),
(11, 200, 11, 11, 11, 112),
(12, 210, 12, 12, 12, 113),
(13, 220, 13, 13, 13, 114),
(14, 230, 14, 14, 14, 115),
(15, 240, 15, 15, 15, 116),
(16, 250, 1, 1, 1, 117),
(17, 260, 2, 2, 2, 118),
(18, 270, 3, 3, 3, 119),
(19, 280, 4, 4, 4, 120),
(20, 290, 5, 5, 5, 121),
(21, 160, 16, 8, 7, 122),
(22, 160, 5, 8, 7, 123);

SELECT * FROM MedicalRecords


-- THIS WAS USED TO ALTER THE DATA TYPE OF DIAGNOSISID FROM NVACHAR TO INT
ALTER TABLE MedicalRecords DROP CONSTRAINT FK__MedicalRe__Diagn__5535A963;
ALTER TABLE Diagnosis DROP CONSTRAINT PK__Diagnosi__0C54CB937607D8CD;
ALTER TABLE Diagnosis ALTER COLUMN DiagnosisID INT NOT NULL;
ALTER TABLE Diagnosis ADD CONSTRAINT PK_Diagnosis_DiagnosisID PRIMARY KEY (DiagnosisID);
ALTER TABLE MedicalRecords ALTER COLUMN DiagnosisID INT;
ALTER TABLE MedicalRecords ADD CONSTRAINT FK__MedicalRe__Diagn__5535A963 FOREIGN KEY (DiagnosisID) REFERENCES Diagnosis(DiagnosisID);

-------------------------PART2---------------------------------------------

--ANSWER TO QUESTION 2--(Add the constraint to check that the appointment date is not in the past)

ALTER TABLE Appointment
ADD CONSTRAINT CHK_AppointmentDate CHECK (AppointmentDate >= CAST(GETDATE() AS DATE))

--ANSWER TO QUESTION 3--(List all the patients with older than 40 and have Cancer in diagnosis.)

SELECT DISTINCT P.PatientID, P.FullName, P.DateOfBirth
FROM Patients P
JOIN MedicalRecords MR ON P.PatientID = MR.PatientID
JOIN Diagnosis D ON MR.DiagnosisID = D.DiagnosisID
WHERE D.DrDiagnosis = 'Cancer'
AND DATEDIFF(YEAR, P.DateOfBirth, GETDATE()) > 40;

--ANSWER TO QUESTION 4(A) Search the database of the hospital for matching character strings by name of medicine. Results should be sorted with most recent medicine prescribed date first.

CREATE PROCEDURE SearchByMedName
    @MedicineName NVARCHAR(100)
AS
BEGIN
    SELECT * FROM Medicines
    WHERE MedicineName LIKE '%' + @MedicineName + '%'
    ORDER BY PrescriptionDate DESC;
END;
--- TO EXECUTE  THE PROCEDURE--
EXEC SearchByMedName '%in%'



--ANSWER TO QUESTION 4(B) Return a full list of diagnosis and allergies for a specific patient who has anappointment today

CREATE PROCEDURE DiagnosisNAllergiesForPatientOnAppttdy
    @PatientID INT
AS
BEGIN
    DECLARE @Today DATE = GETDATE();
    
    SELECT P.FullName AS PatientName, D.DrDiagnosis AS Diagnosis, A.AllergyName AS Allergy, AP.AppointmentDate
	FROM MedicalRecords MR
	JOIN Patients P ON MR.PatientID = P.PatientID
	JOIN Appointments AP ON P.PatientID = AP.PatientID
    LEFT JOIN Diagnosis D ON MR.DiagnosisID = D.DiagnosisID
    LEFT JOIN Allergies A ON MR.AllergyID = A.AllergyID
	WHERE MR.PatientID = @PatientID
        AND AppointmentDate = @Today
END;
--- TO EXECUTE THE PROCEDURE
EXEC DiagnosisNAllergiesForPatientOnAppttdy @PatientID = 22;



--ANSWER TO QUESTION 4(C)Update the details for an existing doctor

CREATE PROCEDURE UpdateDoctorDetails 
    @DoctorID INT,
    @FullName NVARCHAR(100),
    @Specialization NVARCHAR(100),
    @DepartmentID INT,
	@DrAvailability NVARCHAR (20)
AS
BEGIN
    UPDATE Doctors
    SET 
        FullName = @FullName,
        Specialization = @Specialization,
        DepartmentID = @DepartmentID,
		DrAvailability = @DrAvailability
    WHERE 
        DoctorID = @DoctorID;
END;
--- TO EXECUTE THE PROCEDURE----
EXEC UpdateDoctorDetails 
    @DoctorID = 100, 
    @FullName = 'Dr. Illiya', 
    @Specialization = 'Oncologist', 
    @DepartmentID = 250,
	@DrAvailability = 'Unavailable'
	SELECT * FROM Doctors

--ANSWER TO QUESTION 4(D) Delete the appointment who status is already complete

CREATE PROCEDURE DeleteAppointment
AS
BEGIN
    
    INSERT INTO PastAppointments (AppointmentDate, AppointmentTime, AppointmentStatus)
    SELECT 
        AppointmentDate,
        AppointmentTime,
        AppointmentStatus
    FROM 
        Appointments
    WHERE 
        AppointmentStatus = 'Completed';

    -- Delete completed appointments from the Appointment table
    DELETE FROM Appointments
    WHERE 
        AppointmentStatus = 'Completed';
END;
--- TO EXECUTE THE PROCEDURE----
EXEC DeleteAppointment;

SELECT * FROM Appointments
SELECT * FROM PastAppointments

--ANSWER TO QUESTION 5 You should create a view containing all the required information.

CREATE VIEW GenHospitalView AS
SELECT
    A.AppointmentID,
    A.AppointmentDate,
    A.AppointmentTime,
    D.FullName AS DoctorName,
    D.Specialization AS DoctorSpecialty,
    DP.DepartmentName AS Department,
    PA.Feedback AS ReviewFeedback
FROM
    Appointments A
JOIN
    Doctors D ON A.DoctorID = D.DoctorID
JOIN
    Departments DP ON A.DepartmentID = DP.DepartmentID
LEFT JOIN
    MedicalRecords MR ON A.AppointmentID = MR.PastAppointmentID
LEFT JOIN
    PastAppointments PA ON MR.PastAppointmentID = PA.PastAppointmentID;



	select * from GenHospitalView


--ANSWER TO QUESTION 6 Create a trigger so that the current state of an appointment can be changed toavailable when it is cancelled.
-- i had to alter the table as i didnt have 'Available in my initial table creation code'
ALTER TABLE Appointments
ADD CONSTRAINT CHK_AppointmentStatus
CHECK (AppointmentStatus IN ('Pending', 'Cancelled', 'Completed', 'Available'));

ALTER TABLE Appointments NOCHECK CONSTRAINT CK__Appointme__Appoi__46E78A0C;

DROP TRIGGER trg_CancelledAppointment
CREATE TRIGGER trg_CancelledAppointment
ON Appointments
AFTER UPDATE
AS
BEGIN
    IF UPDATE(AppointmentStatus)
    BEGIN
        UPDATE Appointments
        SET AppointmentStatus = 'Available'
		FROM inserted
        WHERE inserted.AppointmentStatus='Cancelled' AND Appointments.AppointmentID = inserted.AppointmentID
              
    END
END;
--EXECUTE TRIGGER
UPDATE Appointments
SET AppointmentStatus = 'Cancelled'
WHERE AppointmentID = 1003;

SELECT * From Appointments


--ANSWER TO QUESTION 7 Write a select query which allows the hospital to identify the number of completed appointments with the specialty of doctors as ‘Gastroenterologists’.

SELECT COUNT(*) AS NumCompletedAppointments
FROM MedicalRecords MR
JOIN Doctors D ON MR.DoctorID = D.DoctorID
JOIN PastAppointments PA ON MR.PastAppointmentID = PA.PastAppointmentID
WHERE D.Specialization = 'Gastroenterologists'
AND PA.AppointmentStatus = 'Completed';

--FOR DATABASE SECURITY I CREATED LOGIN FOR THOSE WHO HAVE ACCESS TO THE DATABASE AND ALSO RESTRICTED ACCESS PERMISSION WITHING THE DATABASE
CREATE LOGIN HOD WITH PASSWORD ='HoD56$#'
CREATE LOGIN ITDEPT WITH PASSWORD = 'It?6%89D'
CREATE LOGIN DOCS WITH PASSWORD = 'DOc89$%'

--CREATING THE TWO USERS
CREATE USER HOD FOR LOGIN HOD
CREATE USER ITDEPT FOR LOGIN ITDEPT
CREATE USER DOCS FOR LOGIN DOCS

--GRANTING PERMISSION
GRANT SELECT ON  GenHospitalView to HOD
GRANT EXECUTE ON SearchByMedName to DOCS
GRANT SELECT ON Patients TO DOCS
GRANT SELECT ON MedicalRecords TO DOCS

--TO CREATE MAINTAINANCE PLAN FOR THE DATABASE
USE master;
GO
SP_CONFIGURE 'SHOW 
ADVANCE',1  
GO 
RECONFIGURE WITH 
OVERRIDE  
GO 
SP_CONFIGURE 'AGENT 
XPs',1
GO 
RECONFIGURE WITH 
OVERRIDE 
GO 

---TO ENSURE MY BACKUP CAN BE RESTORED
BACKUP DATABASE HospitalDB
TO DISK ='C:\HospitalDB_Backup\HospitalDBcheck.bak'  
WITH CHECKSUM 

RESTORE VERIFYONLY 
FROM DISK 
='C:\HospitalDB_Backup\HospitalDBcheck.bak'  
WITH CHECKSUM; 

