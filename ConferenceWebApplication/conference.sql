DROP DATABASE IF EXISTS conferenceDB;
CREATE DATABASE conferenceDB;
USE conferenceDB;

-- Member Table
CREATE TABLE member (
    id INTEGER PRIMARY KEY,
    firstname VARCHAR(100) NOT NULL,
    lastname VARCHAR(100) NOT NULL
);

-- Subcommittee Table
CREATE TABLE subcommitee (
    commiteeName VARCHAR(50) PRIMARY KEY,
    chairID INTEGER NOT NULL,
    FOREIGN KEY (chairID) REFERENCES member(id) ON DELETE CASCADE
);

-- Membership in a Subcommittee
CREATE TABLE onSubcommitee (
    commiteeName VARCHAR(50) NOT NULL,
    memberID INTEGER NOT NULL,
    PRIMARY KEY (commiteeName, memberID),
    FOREIGN KEY (commiteeName) REFERENCES subcommitee(commiteeName) ON DELETE CASCADE,
    FOREIGN KEY (memberID) REFERENCES member(id) ON DELETE CASCADE
);

-- Student Table
CREATE TABLE student (
    id INTEGER PRIMARY KEY,
    firstname VARCHAR(100) NOT NULL,
    lastname VARCHAR(100) NOT NULL,
    rate DECIMAL(10,2) NOT NULL,
    email VARCHAR(50) NOT NULL
);

-- Professional Table
CREATE TABLE professional (
    id INTEGER PRIMARY KEY,
    firstname VARCHAR(100) NOT NULL,
    lastname VARCHAR(100) NOT NULL,
    rate DECIMAL(10,2) NOT NULL,
    email VARCHAR(50) NOT NULL
);

-- Sponsoring Company Table
CREATE TABLE sponsoringCompany (
    nameOfCompany VARCHAR(100) PRIMARY KEY,
    emailsSent INTEGER NOT NULL,
    sponsorLevel VARCHAR(20) NOT NULL
);

-- Sponsor Table
CREATE TABLE sponsor (
    id INTEGER PRIMARY KEY,
    firstname VARCHAR(100) NOT NULL,
    lastname VARCHAR(100) NOT NULL,
    rate DECIMAL(10,2) NOT NULL,
    email VARCHAR(50) NOT NULL,
    sentBy VARCHAR(100) NOT NULL,
    FOREIGN KEY (sentBy) REFERENCES sponsoringCompany(nameOfCompany) ON DELETE CASCADE
);

-- Speaker Table
CREATE TABLE speaker (
    id INTEGER PRIMARY KEY,
    firstname VARCHAR(100) NOT NULL,
    lastname VARCHAR(100) NOT NULL,
    rate DECIMAL(10,2) NOT NULL,
    email VARCHAR(50) NOT NULL
);

-- Hotel Room Table
CREATE TABLE hotelRoom (
    roomNumber INTEGER PRIMARY KEY,
    numOfBeds INTEGER NOT NULL
);

-- Session Table
CREATE TABLE session (
    sessionDate DATE NOT NULL,
    startTime TIME NOT NULL,
    sessionLocation VARCHAR(100) NOT NULL,
    endTime TIME NOT NULL,
    nameOfSession VARCHAR(100) NOT NULL,
    PRIMARY KEY (sessionDate, startTime, sessionLocation)
);

-- Job Advertisement Table
CREATE TABLE jobAd (
    jobID INTEGER NOT NULL,
    postingCompany VARCHAR(100) NOT NULL,
    payRate DECIMAL(10,2) NOT NULL,
    city VARCHAR(50) NOT NULL,
    province VARCHAR(25) NOT NULL,
    jobTitle VARCHAR(100) NOT NULL,
    PRIMARY KEY (jobID, postingCompany),
    FOREIGN KEY (postingCompany) REFERENCES sponsoringCompany(nameOfCompany) ON DELETE CASCADE
);

-- Speaker Assignments to Sessions
CREATE TABLE speaksAtSession (
    speakerID INTEGER NOT NULL,
    dateOfSession DATE NOT NULL,
    startTimeOfSession TIME NOT NULL,
    locationOfSession VARCHAR(100) NOT NULL,
    PRIMARY KEY (speakerID, dateOfSession, startTimeOfSession, locationOfSession),
    FOREIGN KEY (speakerID) REFERENCES speaker(id) ON DELETE CASCADE,
    FOREIGN KEY (dateOfSession, startTimeOfSession, locationOfSession) 
        REFERENCES session(sessionDate, startTime, sessionLocation) 
        ON DELETE CASCADE
);



-- Inserting Values into Tables
-- Insert members
INSERT INTO member (id, firstname, lastname) VALUES
(1, 'Alice', 'Brown'),
(2, 'Bob', 'Smith'),
(3, 'Charlie', 'Davis'),
(4, 'Diana', 'White'),
(5, 'Ethan', 'Black'),
(6, 'Fiona', 'Green'),
(7, 'George', 'Adams'),
(8, 'Hannah', 'Parker');

-- Insert subcommittees
INSERT INTO subcommitee (commiteeName, chairID) VALUES
('Program Committee', 1),
('Registration Committee', 2),
('Sponsorship Committee', 3),
('Logistics Committee', 4),
('Tech Support Committee', 5),
('Marketing Committee', 6);

-- Insert members into subcommittees
INSERT INTO onSubcommitee (commiteeName, memberID) VALUES
('Program Committee', 1),
('Program Committee', 2),
('Registration Committee', 3),
('Registration Committee', 4),
('Sponsorship Committee', 5),
('Sponsorship Committee', 6),
('Tech Support Committee', 7),
('Marketing Committee', 8);

-- Insert students
INSERT INTO student (id, firstname, lastname, rate, email) VALUES
(1, 'Jack', 'Miller', 50.00, 'jack.miller@example.com'),
(2, 'Emma', 'Wilson', 50.00, 'emma.wilson@example.com'),
(3, 'Noah', 'Taylor', 50.00, 'noah.taylor@example.com'),
(4, 'Olivia', 'Anderson', 50.00, 'olivia.anderson@example.com'),
(5, 'Liam', 'Thomas', 50.00, 'liam.thomas@example.com'),
(6, 'Sophia', 'Martinez', 50.00, 'sophia.martinez@example.com');

-- Insert professionals
INSERT INTO professional (id, firstname, lastname, rate, email) VALUES
(1, 'Michael', 'Clark', 100.00, 'michael.clark@example.com'),
(2, 'Sarah', 'Rodriguez', 100.00, 'sarah.rodriguez@example.com'),
(3, 'David', 'Lopez', 100.00, 'david.lopez@example.com'),
(4, 'Jessica', 'Harris', 100.00, 'jessica.harris@example.com'),
(5, 'Chris', 'Young', 100.00, 'chris.young@example.com'),
(6, 'Emily', 'King', 100.00, 'emily.king@example.com');

-- Insert sponsoring companies
INSERT INTO sponsoringCompany (nameOfCompany, emailsSent, sponsorLevel) VALUES
('TechCorp', 3, 'Silver'),
('DataSystems', 5, 'Platinum'),
('InnovateAI', 4, 'Gold'),
('GreenEnergy', 2, 'Bronze'),
('CyberNet', 5, 'Platinum'),
('HealthTech', 3, 'Silver');

-- Insert sponsors
INSERT INTO sponsor (id, firstname, lastname, rate, email, sentBy) VALUES
(1, 'Brian', 'Lee', 0.00, 'brian.lee@techcorp.com', 'TechCorp'),
(2, 'Anna', 'Wright', 0.00, 'anna.wright@datasystems.com', 'DataSystems'),
(3, 'Kevin', 'Scott', 0.00, 'kevin.scott@innovateai.com', 'InnovateAI'),
(4, 'Laura', 'Evans', 0.00, 'laura.evans@greenenergy.com', 'GreenEnergy'),
(5, 'Jason', 'Nelson', 0.00, 'jason.nelson@cybernet.com', 'CyberNet'),
(6, 'Rachel', 'Baker', 0.00, 'rachel.baker@healthtech.com', 'HealthTech');

-- Insert speakers
INSERT INTO speaker (id, firstname, lastname, rate, email) VALUES
(1, 'Tom', 'Bennett', 100.00, 'tom.bennett@example.com'),
(2, 'Samantha', 'Hall', 100.00, 'samantha.hall@example.com'),
(3, 'Ryan', 'Perez', 100.00, 'ryan.perez@example.com'),
(4, 'Natalie', 'Collins', 100.00, 'natalie.collins@example.com'),
(5, 'Jake', 'Murphy', 100.00, 'jake.murphy@example.com'),
(6, 'Sophia', 'Bryant', 100.00, 'sophia.bryant@example.com');

-- Insert hotel rooms
INSERT INTO hotelRoom (roomNumber, numOfBeds) VALUES
(101, 2),
(102, 2),
(103, 1),
(104, 1),
(105, 2),
(106, 2);

-- Insert sessions
INSERT INTO session (sessionDate, startTime, sessionLocation, endTime, nameOfSession) VALUES
('2025-06-10', '09:00:00', 'Room A', '10:30:00', 'AI in Healthcare'),
('2025-06-10', '11:00:00', 'Room B', '12:30:00', 'Cybersecurity Trends'),
('2025-06-10', '14:00:00', 'Room C', '15:30:00', 'Blockchain and Finance'),
('2025-06-11', '09:00:00', 'Room D', '10:30:00', 'Green Energy Innovations'),
('2025-06-11', '11:00:00', 'Room E', '12:30:00', 'Quantum Computing'),
('2025-06-11', '14:00:00', 'Room F', '15:30:00', 'Future of Cloud Computing');

-- Insert job ads
INSERT INTO jobAd (jobID, postingCompany, payRate, city, province, jobTitle) VALUES
(1, 'TechCorp', 120000.00, 'Toronto', 'ON', 'Software Engineer'),
(2, 'DataSystems', 110000.00, 'Vancouver', 'BC', 'Data Scientist'),
(3, 'InnovateAI', 95000.00, 'Montreal', 'QC', 'Machine Learning Engineer'),
(4, 'GreenEnergy', 90000.00, 'Calgary', 'AB', 'Renewable Energy Analyst'),
(5, 'CyberNet', 115000.00, 'Ottawa', 'ON', 'Cybersecurity Specialist'),
(6, 'HealthTech', 125000.00, 'Edmonton', 'AB', 'Biomedical Engineer');

-- Insert speakers at sessions
INSERT INTO speaksAtSession (speakerID, dateOfSession, startTimeOfSession, locationOfSession) VALUES
(1, '2025-06-10', '09:00:00', 'Room A'),
(2, '2025-06-10', '11:00:00', 'Room B'),
(3, '2025-06-10', '14:00:00', 'Room C'),
(4, '2025-06-11', '09:00:00', 'Room D'),
(5, '2025-06-11', '11:00:00', 'Room E'),
(6, '2025-06-11', '14:00:00', 'Room F');