CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_HCTCAPCOADDNEW" (pnIni NUMBER,
                                      pnFin NUMBER,
                                pnKeyPlz NUMBER,
                                ps_validapres VARCHAR2,
                                pd_costUni NUMBER,
                                ps_key_dep VARCHAR2,
                                ps_key_pue VARCHAR2,
                                pn_pre_anio NUMBER
                                ) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    num_fil number(10);
BEGIN
   IF ps_validapres = 'S' THEN
      -- ACTUALIZAMOS EL PRESUPUESTO EJERCIDO EN NMLOPRES
      UPDATE USRSIHO.holopres
         SET pre_ejerci = pre_ejerci + ((pnFin - pnIni) + 1) * pd_costUni
       WHERE pre_keydep = ps_key_dep
         AND pre_keypue = ps_key_pue
         AND pre_anio = pn_pre_anio;
   END IF;
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
