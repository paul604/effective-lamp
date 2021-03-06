/*
* trigger sup Emprunt quans le dernier ExemplaireEmprunte a ete sup
*/
create or replace trigger sup_exEmp
    AFTER DELETE ON EXEMPLAIREEMPRUNTE
BEGIN
    DELETE FROM Emprunt WHERE (Emprunt.NUMA, Emprunt.DATEE) NOT IN
        (SELECT EXEMPLAIREEMPRUNTE.NUMA, EXEMPLAIREEMPRUNTE.DATEE FROM EXEMPLAIREEMPRUNTE);
END;
