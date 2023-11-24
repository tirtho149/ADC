-- Patients table
CREATE TABLE Patients (
    PatientID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    DateOfBirth DATE,
    ContactNumber VARCHAR(15),
    Email VARCHAR(100),
    Address VARCHAR(255),
    RegistrationDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_date_of_birth CHECK (DateOfBirth <= CURRENT_DATE),
    CONSTRAINT chk_contact_number CHECK (LENGTH(ContactNumber) >= 10 AND LENGTH(ContactNumber) <= 15)
);

-- Appointments table
CREATE TABLE Appointments (
    AppointmentID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    AppointmentDateTime DATETIME,
    Purpose VARCHAR(255),
    Notes TEXT,
    CONSTRAINT fk_patient
        FOREIGN KEY (PatientID) 
        REFERENCES Patients(PatientID)
        ON DELETE CASCADE
);

-- MedicalHistory table
CREATE TABLE MedicalHistory (
    MedicalHistoryID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    MedicalCondition VARCHAR(255),
    Medications TEXT,
    Allergies TEXT,
    Surgeries TEXT,
    CONSTRAINT fk_patient_medical
        FOREIGN KEY (PatientID) 
        REFERENCES Patients(PatientID)
        ON DELETE CASCADE
);

-- UserAccounts table (for authentication, assuming a simple scenario)
CREATE TABLE UserAccounts (
    UserID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    Username VARCHAR(50) UNIQUE NOT NULL,
    PasswordHash VARCHAR(255) NOT NULL,
    CONSTRAINT fk_patient_user
        FOREIGN KEY (PatientID) 
        REFERENCES Patients(PatientID)
        ON DELETE CASCADE
);

-- GamifiedOralHealthTracker table
CREATE TABLE GamifiedOralHealthTracker (
    TrackerID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    DailyBrushingScore INT,
    Achievements TEXT,
    Rewards TEXT,
    CONSTRAINT fk_patient_tracker
        FOREIGN KEY (PatientID) 
        REFERENCES Patients(PatientID)
        ON DELETE CASCADE
);

-- CommunityEngagement table
CREATE TABLE CommunityEngagement (
    PostID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    PostText TEXT,
    PostDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_patient_post
        FOREIGN KEY (PatientID) 
        REFERENCES Patients(PatientID)
        ON DELETE CASCADE
);

-- SmartAppointmentScheduling table
CREATE TABLE SmartAppointmentScheduling (
    AppointmentID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    AppointmentDateTime DATETIME,
    ProcedureType VARCHAR(100),
    Status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    CONSTRAINT fk_patient_appointment
        FOREIGN KEY (PatientID) 
        REFERENCES Patients(PatientID)
        ON DELETE CASCADE
);

-- AI_PoweredDiagnostics table
CREATE TABLE AI_PoweredDiagnostics (
    DiagnosticID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    Diagnosis TEXT,
    Recommendation TEXT,
    DiagnosticDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_patient_diagnostic
        FOREIGN KEY (PatientID) 
        REFERENCES Patients(PatientID)
        ON DELETE CASCADE
);

-- BillingAndInvoicing table
CREATE TABLE BillingAndInvoicing (
    InvoiceID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    AppointmentID INT,
    Amount DECIMAL(10, 2),
    InvoiceDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PaymentStatus ENUM('Pending', 'Paid') DEFAULT 'Pending',
    CONSTRAINT fk_patient_invoice
        FOREIGN KEY (PatientID) 
        REFERENCES Patients(PatientID)
        ON DELETE CASCADE,
    CONSTRAINT fk_appointment_invoice
        FOREIGN KEY (AppointmentID) 
        REFERENCES SmartAppointmentScheduling(AppointmentID)
        ON DELETE CASCADE
);
