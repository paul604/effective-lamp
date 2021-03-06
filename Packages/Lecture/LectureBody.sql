/*
* body Lecture
*/
create or replace PACKAGE BODY Lecture IS

PROCEDURE listAdherent(liste out liste_Cursor) IS
    BEGIN
        SET TRANSACTION READ ONLY;
        OPEN liste FOR SELECT * FROM ADHERENT;
        COMMIT;
    END;

PROCEDURE listEmpruntsForAdherent(idAdh NUMBER, liste out liste_Cursor) IS
    BEGIN
        SET TRANSACTION READ ONLY;
        OPEN liste FOR
            SELECT Exemplaire.NUMINV, Livre.titre
                FROM Livre, EXEMPLAIRE
                WHERE Livre.ISBN = EXEMPLAIRE.ISBN
                    AND EXEMPLAIRE.numInv IN (
                        SELECT numInv
                        FROM ExemplaireEmprunte
                        WHERE numA = idAdh
                    );
        COMMIT;
    END;

PROCEDURE listLivre(liste out liste_Cursor) IS
    BEGIN
        SET TRANSACTION READ ONLY;
        OPEN liste FOR
            SELECT ISBN, Titre,
                (SELECT COUNT(*)
                    FROM EXEMPLAIRE ex
                    WHERE ex.ISBN = liv.ISBN
                ) nb_exemplaire,
                (SELECT COUNT(*)
                    FROM EXEMPLAIRE ex
                    WHERE ex.ISBN = liv.ISBN
                        AND ex.NUMINV NOT IN (
                            SELECT NUMINV
                            FROM EXEMPLAIREEMPRUNTE exEp
                        )
                ) nb_libre
            FROM Livre liv;
        COMMIT;
    END;

PROCEDURE listAdherentRetard(liste out liste_Cursor) IS
    BEGIN
        SET TRANSACTION READ ONLY;
        OPEN liste FOR
            SELECT adh.numA, adh.NOM, emp.DATEE, exEmp.NUMINV, liv.TITRE
                FROM ADHERENT adh,
                EMPRUNT emp,
                EXEMPLAIREEMPRUNTE exEmp,
                EXEMPLAIRE ex,
                LIVRE liv
                WHERE adh.NUMA = emp.NUMA
                    AND emp.DATER < SYSDATE
                    AND emp.NUMA = exEmp.NUMA
                    AND emp.dateE = exEmp.dateE
                    AND exEmp.NUMINV = ex.NUMINV
                    AND ex.ISBN = liv.ISBN;
        COMMIT;
        END;
END;
