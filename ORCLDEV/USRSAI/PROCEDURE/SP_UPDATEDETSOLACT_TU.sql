CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSAI"."SP_UPDATEDETSOLACT_TU" ( NUMSOL IN NUMBER,       idereg IN NUMBER, keyemp IN NUMBER,       nomart IN VARCHAR2,
                                                            person IN VARCHAR2,     keypue IN VARCHAR2,     keynac IN VARCHAR2,
                                                            numcap IN VARCHAR2,     coment IN VARCHAR2,     stsreg IN NUMBER,
                                                            tipodis IN VARCHAR2,    revdis IN VARCHAR2,     sindicato IN VARCHAR2,
                                                            aux OUT NUMBER)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
            aux := 0;
                 SELECT COUNT(*) INTO aux
                  FROM detsolact
                  WHERE dsa_numsol = numsol
                  and dsa_idereg = idereg;
    IF aux > 0 THEN
        UPDATE DETSOLACT
        SET DSA_KEYEMP = keyemp,
            dsa_nomart = nomart,
            dsa_person = person,
            dsa_keypue = keypue,
            dsa_keynac = keynac,
            dsa_numcap = numcap,
            dsa_coment = coment,
            dsa_stsreg = stsreg,
            dsa_tipodis = tipodis,
            dsa_revdis = revdis,
            dsa_sindicato = sindicato
        WHERE dsa_numsol = numsol
        and dsa_idereg = idereg;
    END IF;
END;
/
