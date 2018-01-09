/*
*   TD1 
*   Create table
*/
CREATE TABLE Adherent (
    numA NUMBER(4) PRIMARY KEY,
    nom VARCHAR(20),
    prenom VARCHAR(20),
    adresse VARCHAR(20)
);

CREATE TABLE Emprunt (
    numA NUMBER(4),
    dateE DATE,
    dateR DATE,
    PRIMARY KEY (numeroA, dateE),
    FOREIGN KEY (numeroA) REFERENCES Adherent(numeroA)
);

CREATE TABLE Livre (
    ISBN NUMBER(8),
    titre VARCHAR,
    edtiteur VARCHAR,
    aneeParution NUMBER(4),
    auteurs VARCHAR,
    nbE NUMBER,
    dateDE DATE,
    PRIMARY KEY (ISBN)
);

CREATE TABLE Exemplaire (
    numInv NUMBER,
    ISBN NUMBER(4),
    PRIMARY KEY (numInv),
    FOREIGN KEY (ISBN) REFERENCES Livre(ISBN)
);

CREATE TABLE ExemplaireEmprunte (
    numInv NUMBER,
    numA NUMBER(4),
    dateE DATE,
    PRIMARY KEY (numInv),
    FOREIGN KEY (numA, dateE) REFERENCES Emprunt(numA, dateE)
);