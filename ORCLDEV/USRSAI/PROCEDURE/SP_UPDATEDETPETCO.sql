CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSAI"."SP_UPDATEDETPETCO" (   numpco IN NUMBER, idereg IN NUMBER, clasif IN VARCHAR2,
                                                            tabulador IN NUMBER, sindicato IN VARCHAR2, siscon IN VARCHAR2,
                                                            fecgra IN VARCHAR2, person IN VARCHAR2, numcap IN VARCHAR2,
                                                            tabulade IN NUMBER, padiftab IN NUMBER, totcap IN NUMBER,
                                                            conjunto IN VARCHAR2,   tipval IN NUMBER, tipopago NUMBER,
                                                            numllamados NUMBER,    cont OUT NUMBER)
			--Se agrego numllamados como un argumento al final IG-CONS-0823
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
		SELECT COUNT(*) INTO cont FROM detpetco
		WHERE dpc_idereg = idereg AND dpc_numpco = numpco;
	IF cont >= 1 THEN
		--Se especifico la actualizaci?el campo dpc_numllama con el valor del argumento numllamados IG-CONS-0823
		UPDATE detpetco
		SET dpc_clasif = clasif,
			dpc_tabulador = tabulador,
			dpc_sindicato = sindicato,
			dpc_siscon = siscon,
			dpc_fecgra = TO_DATE(fecgra,'dd/mm/yyyy'),
			dpc_person = person,
			dpc_numcap = numcap,
			dpc_tabulade = tabulade,
			dpc_padiftab = padiftab,
			dpc_totcap = totcap,
			dpc_conjunto = conjunto,
			dpc_tipval = tipval,
			dpc_tipopago = tipopago,
			dpc_numllama = numllamados
		WHERE dpc_idereg = idereg
			AND dpc_numpco = numpco;
	END IF;
END;
/
