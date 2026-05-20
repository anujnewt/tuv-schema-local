CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSAI"."SP_INSERTDETSOLACT" ( NUMSOL IN NUMBER,       keyemp IN NUMBER,       nomart IN VARCHAR2,
                                                            person IN VARCHAR2,     keypue IN VARCHAR2,     keynac IN VARCHAR2,
                                                            numcap IN VARCHAR2,     coment IN VARCHAR2,     stsreg IN NUMBER,
                                                            tipodis IN VARCHAR2,    revdis IN VARCHAR2,     sindicato IN VARCHAR2,
                                                            sigID OUT NUMBER)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
            sigID := 0;
            SELECT COALESCE(MAX(DSA_IDEREG), 0) + 1 INTO sigID FROM DETSOLACT
            WHERE DSA_NUMSOL = NUMSOL;
                        INSERT INTO detsolact(  dsa_numsol, dsa_idereg, dsa_keyemp, dsa_nomart,     dsa_person,     dsa_keypue, dsa_keynac,
                                                dsa_numcap, dsa_coment, dsa_stsreg, dsa_tipodis,    dsa_revdis,     dsa_sindicato)
                                      VALUES (  NUMSOL,     sigID,      keyemp,     nomart,         person,         keypue,     keynac,
                                                numcap,     coment,     stsreg,     tipodis,        revdis,         sindicato);
END;
/
