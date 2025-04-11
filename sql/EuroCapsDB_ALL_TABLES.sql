
DROP DATABASE IF EXISTS EuroCapsDB;
CREATE DATABASE EuroCapsDB;
USE EuroCapsDB;

-- Soort_partner
CREATE TABLE Soort_partner (
  SoortPartnerID INT PRIMARY KEY,
  Omschrijving VARCHAR(255)
);

-- PartnerContact
CREATE TABLE PartnerContact (
  PartnerContactID INT PRIMARY KEY,
  Voornaam VARCHAR(100),
  Achternaam VARCHAR(100),
  Functie VARCHAR(50),
  Email VARCHAR(100),
  Telnr INT
);

-- Levering
CREATE TABLE Levering (
  LeveringID INT PRIMARY KEY,
  LeveringDatum DATE,
  VerwachteLeverdatum DATE
);

-- Partner
CREATE TABLE Partner (
  PartnerID INT PRIMARY KEY,
  SoortPartnerID INT,
  PartnerContactID INT,
  LeveringID INT,
  Bedrijfsnaam VARCHAR(100),
  Straatnaam VARCHAR(100),
  Huisnummer INT,
  Postcode VARCHAR(10),
  Plaats VARCHAR(100),
  Land VARCHAR(100),
  Email VARCHAR(100),
  Telnr INT,
  FOREIGN KEY (SoortPartnerID) REFERENCES Soort_partner(SoortPartnerID),
  FOREIGN KEY (PartnerContactID) REFERENCES PartnerContact(PartnerContactID),
  FOREIGN KEY (LeveringID) REFERENCES Levering(LeveringID)
);

-- SoortProduct
CREATE TABLE SoortProduct (
  SoortProductID INT PRIMARY KEY,
  Omschrijving VARCHAR(255),
  Gewicht INT,
  Afmeting INT,
  Materiaal VARCHAR(100)
);

-- KwaliteitCheck
CREATE TABLE KwaliteitCheck (
  KwaliteitCheckID INT PRIMARY KEY,
  ControleDatum DATE,
  Afkeurreden VARCHAR(255),
  AantalAfgekeurd INT
);

-- Operator
CREATE TABLE Operator (
  OperatorID INT PRIMARY KEY,
  NaamOperator VARCHAR(100),
  Afdeling VARCHAR(50)
);

-- Product
CREATE TABLE Product (
  ProductID INT PRIMARY KEY,
  SoortProductID INT,
  KwaliteitCheckID INT,
  ProductTHTDatum DATE,
  CStatusProduct VARCHAR(15),
  FStatusProduct VARCHAR(15),
  PStatusProduct VARCHAR(15),
  FOREIGN KEY (SoortProductID) REFERENCES SoortProduct(SoortProductID),
  FOREIGN KEY (KwaliteitCheckID) REFERENCES KwaliteitCheck(KwaliteitCheckID)
);

-- ProcesLog
CREATE TABLE ProcesLog (
  ProcesLogID INT PRIMARY KEY,
  ProductID INT,
  OperatorID INT,
  ProcesStap VARCHAR(255),
  Status INT,
  TijdstipLog DATETIME,
  FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
  FOREIGN KEY (OperatorID) REFERENCES Operator(OperatorID)
);

-- LeveringRegel
CREATE TABLE LeveringRegel (
  LeveringID INT,
  ProductID INT,
  Aantal INT,
  PRIMARY KEY (LeveringID, ProductID),
  FOREIGN KEY (LeveringID) REFERENCES Levering(LeveringID),
  FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- Grinding
CREATE TABLE Grinding (
  GrindingID INT PRIMARY KEY,
  OperatorID INT,
  G_DatumTijdStart DATETIME,
  G_DatumTijdEind DATETIME,
  G_Machine VARCHAR(50),
  FOREIGN KEY (OperatorID) REFERENCES Operator(OperatorID)
);

-- Grinding_Product
CREATE TABLE Grinding_Product (
  GrindingID INT,
  ProductID INT,
  Aantal INT,
  PRIMARY KEY (GrindingID, ProductID),
  FOREIGN KEY (GrindingID) REFERENCES Grinding(GrindingID),
  FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- Filling
CREATE TABLE Filling (
  FillingID INT PRIMARY KEY,
  OperatorID INT,
  F_DatumTijdStart DATETIME,
  F_DatumTijdEind DATETIME,
  F_Machine VARCHAR(50),
  FOREIGN KEY (OperatorID) REFERENCES Operator(OperatorID)
);

-- Filling_Product
CREATE TABLE Filling_Product (
  FillingID INT,
  ProductID INT,
  Aantal INT,
  PRIMARY KEY (FillingID, ProductID),
  FOREIGN KEY (FillingID) REFERENCES Filling(FillingID),
  FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- Packaging
CREATE TABLE Packaging (
  PackagingID INT PRIMARY KEY,
  OperatorID INT,
  P_DatumTijdStart DATETIME,
  P_DatumTijdEind DATETIME,
  P_Machine VARCHAR(50),
  AantalStuksInDoos INT,
  FOREIGN KEY (OperatorID) REFERENCES Operator(OperatorID)
);

-- Packaging_Product
CREATE TABLE Packaging_Product (
  PackagingID INT,
  ProductID INT,
  Aantal INT,
  PRIMARY KEY (PackagingID, ProductID),
  FOREIGN KEY (PackagingID) REFERENCES Packaging(PackagingID),
  FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);
