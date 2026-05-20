CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSAI"."SP_INSERTDETPETCO" ( numpco IN NUMBER, keyemp IN NUMBER,   nomart IN VARCHAR2,
                                                          clasif IN VARCHAR2,   tabulador IN NUMBER,    sindicato IN VARCHAR2,
                                                          siscon IN VARCHAR2, fecgra IN VARCHAR2, nomreal IN VARCHAR2,
                                                          person IN VARCHAR2,   numcap IN VARCHAR2, tabulade IN NUMBER,
                                                          padiftab IN NUMBER, totcap IN NUMBER, conjunto IN VARCHAR2,
                                                          nacion IN VARCHAR2, idioma IN VARCHAR2, tipval IN NUMBER,
                                                          tipopago IN NUMBER, desclasif IN VARCHAR2, docfis IN VARCHAR2,
                                                          numllamados IN NUMBER,  sigID OUT NUMBER)
--Se agrego numllamados como un argumento al final IG-CONS-0823
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    cont INT;
BEGIN
           sigID := 0;
            SELECT COUNT(*) INTO cont FROM encpetco
            WHERE epc_numpco = numpco;
      IF cont >= 1 THEN
            SELECT COALESCE(MAX(dpc_idereg),0) + 1
            INTO sigID
            FROM detpetco
            WHERE dpc_numpco = numpco;
		--Se especificaco la inserci?el campo dpc_numllama IG-CONS-0823
		INSERT INTO detpetco(dpc_numpco, dpc_idereg, dpc_keyemp, dpc_nomart, dpc_clasif, dpc_descla,
		dpc_tabulador, dpc_sindicato, dpc_siscon, dpc_fecgra, dpc_nomreal, dpc_person, dpc_numcap,
		dpc_tabulade, dpc_padiftab, dpc_totcap, dpc_conjunto, dpc_nacion, dpc_idioma, dpc_tipval,
		dpc_tipopago, dpc_stsreg, dpc_docfis, dpc_numllama)
		VALUES(numpco, sigID, keyemp, nomart, clasif, desclasif, tabulador, sindicato, siscon, TO_DATE(fecgra,'dd/mm/yyyy'),
		nomreal, person, numcap, tabulade, padiftab, totcap, conjunto, nacion, idioma, tipval, tipopago, 1,
 		docfis, numllamados);
      END IF;
END;
/
