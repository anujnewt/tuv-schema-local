CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_HCTCAPCOADD" (pnIni NUMBER,pnFin NUMBER,pnKeyPlz NUMBER) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
 num_fil number(10);
BEGIN
	-- SUMARLE EL NUMERO DE CAPITULOS A HOLOCONT
	UPDATE USRSIHO.holocont
	   SET con_numcap = con_numcap + ((pnFin - pnIni) + 1),
	       con_numcdi = con_numcdi + ((pnFin - pnIni) + 1)
	 WHERE con_keyplz = pnKeyPlz;
	-- INSERTO EN HOLOCOCA  CADA UNO DE LOS CAPITULOS
	FOR num_fil in pnIni..pnFin LOOP
		INSERT INTO USRSIHO.holococa
		           (coc_keyplz,coc_keycap,coc_numsec,coc_stspag,coc_keyrph,coc_keygdp)
		    VALUES (pnKeyPlz,num_fil,1,'V',null,null);
	END LOOP;
END;
/
