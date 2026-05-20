CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SP_NMTRINC2" ( wn_key_pro IN NUMBER,	ws_per_fue IN VARCHAR2,
					     wn_per_cer IN NUMBER,	ws_nom_rep IN VARCHAR2,
					     ws_ide_pcc IN VARCHAR2,	wn_key_usu IN NUMBER,
					     ws_per_des IN VARCHAR2, 	wn_rev_ers IN NUMBER,
						 wn_key_inc IN NUMBER)
    IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    -- Variables para obtener los datos de la tabla de movimientos o hismov
    wn_cve_emp NUMBER(10);
    ws_cve_con CHAR(3);
    wn_cve_pro NUMBER(5);
	wn_cve_nom NUMBER(5);
    ws_cve_dep CHAR(16);
    ws_cve_pue CHAR(16);
    wn_can_tid NUMBER(16,2);
    wn_imp_ort NUMBER(16,2);
    ws_fec_mov DATE;
    ws_cve_per CHAR(7);
    -- Variables para obtener los conceptos en glwkcrys
    ws_con_fue CHAR(3);
    ws_con_des CHAR(3);
    -- Variables auxiliares
    wn_cer_o   NUMBER(5)  := 0;
    wn_reg_ins NUMBER(10) := 0;
    wn_con_reg NUMBER(3)  := 0;
    wn_lim_ite NUMBER(3)  := 100;
	wn_inc_loc NUMBER(16,6);
	wn_con_inc  NUMBER(16,6);
	wn_num_sec NUMBER(5) := 0;
BEGIN
	wn_inc_loc := 0.0;
	wn_con_inc := wn_key_inc;
    -- Si el periodo esta cerrado utiliza nmlohism
    IF wn_per_cer = 1 THEN
	FOR c_hismov IN ( SELECT his_keyemp, his_keycon, his_keypro, his_keydep, his_keypue,
		his_cantid, his_import, his_fecmov, his_keyper,his_keynom
	    FROM nmlohism
	    WHERE his_keyemp IN (SELECT ran_keyemp FROM glwkrang
				WHERE ran_nomrep = ws_nom_rep AND
				    ran_idepcc = ws_ide_pcc AND
				    ran_keyusu = wn_key_usu AND
				    ran_keyemp IS NOT NULL)
		AND his_keypro = wn_key_pro AND his_keyper = ws_per_fue ) LOOP
	    wn_cve_emp := c_hismov.his_keyemp;
	    ws_cve_con := c_hismov.his_keycon;
	    wn_cve_pro := c_hismov.his_keypro;
	    ws_cve_dep := c_hismov.his_keydep;
	    ws_cve_pue := c_hismov.his_keypue;
	    wn_can_tid := c_hismov.his_cantid;
	    wn_imp_ort := c_hismov.his_import;
	    ws_fec_mov := c_hismov.his_fecmov;
	    ws_cve_per := c_hismov.his_keyper;
		wn_cve_nom := c_hismov.his_keynom;
	    -- Si la bandera indica reversion se multiplica la cantidad
	    -- y el importe por -1
	    IF wn_rev_ers = 1 THEN
		wn_can_tid := wn_can_tid * -1;
		wn_imp_ort := wn_imp_ort * -1;
	    END IF;
		wn_num_sec := wn_num_sec + 1;
	    sp_nmkeyinc(wn_key_inc,ws_cve_con,wn_cve_pro,wn_cve_nom,ws_per_des,wn_cve_emp,wn_num_sec,wn_inc_loc);
	    -- Inserta en la tabla de incidencias
	    INSERT INTO nmcoinci
		(inc_keyemp, inc_keycon, inc_keypro, inc_keyper, inc_keydep, inc_keypue,
		 inc_fecmov, inc_cantid, inc_import, inc_diauno, inc_diados, inc_diatre,
		 inc_diacua, inc_diacin, inc_diasei, inc_diasie, inc_keyinc, inc_numfol)
	    VALUES
		(wn_cve_emp, ws_cve_con, wn_cve_pro, ws_per_des, ws_cve_dep, ws_cve_pue,
                 ws_fec_mov, wn_can_tid, wn_imp_ort, wn_cer_o,   wn_cer_o,   wn_cer_o,
		 wn_cer_o,   wn_cer_o,   wn_cer_o,   wn_cer_o,   wn_inc_loc,   wn_cer_o );
	    wn_reg_ins := wn_reg_ins + 1;
	    wn_con_reg := wn_con_reg + 1;
	    IF wn_con_reg >= wn_lim_ite THEN
		COMMIT;
		wn_con_reg := 0;
	    END IF;
	END LOOP;
    END IF;
    -- Si el periodo esta abierto se utiliza la tabla de movtos (nmwkmovt)
    IF wn_per_cer = 0 THEN
	FOR c_movtos IN ( SELECT mov_keyemp, mov_keycon, mov_keypro, mov_keydep, mov_keypue,
				 mov_cantid, mov_import, mov_fecmov, mov_keyper,mov_keynom
	    FROM nmwkmovt
	    WHERE mov_keyemp IN (SELECT ran_keyemp FROM glwkrang
				WHERE ran_nomrep = ws_nom_rep AND
				    ran_idepcc = ws_ide_pcc AND
				    ran_keyusu = wn_key_usu AND
				    ran_keyemp IS NOT NULL)
		AND mov_keypro = wn_key_pro AND mov_keyper = ws_per_fue ) LOOP
	    wn_cve_emp := c_movtos.mov_keyemp;
	    ws_cve_con := c_movtos.mov_keycon;
	    wn_cve_pro := c_movtos.mov_keypro;
	    ws_cve_dep := c_movtos.mov_keydep;
	    ws_cve_pue := c_movtos.mov_keypue;
	    wn_can_tid := c_movtos.mov_cantid;
	    wn_imp_ort := c_movtos.mov_import;
	    ws_fec_mov := c_movtos.mov_fecmov;
	    ws_cve_per := c_movtos.mov_keyper;
   	    wn_cve_nom := c_movtos.mov_keynom;
	    -- Si la bandera indica reversion se multiplica la cantidad
	    -- y el importe por -1
	    IF wn_rev_ers = 1 THEN
		wn_can_tid := wn_can_tid * -1;
		wn_imp_ort := wn_imp_ort * -1;
	    END IF;
		wn_num_sec := wn_num_sec + 1;
		sp_nmkeyinc(wn_key_inc,ws_cve_con,wn_cve_pro,wn_cve_nom,ws_per_des,wn_cve_emp,wn_num_sec,wn_inc_loc);
	    -- Inserta en la tabla de incidencias
	    INSERT INTO nmcoinci
		(inc_keyemp, inc_keycon, inc_keypro, inc_keyper, inc_keydep, inc_keypue,
		 inc_fecmov, inc_cantid, inc_import, inc_diauno, inc_diados, inc_diatre,
		 inc_diacua, inc_diacin, inc_diasei, inc_diasie, inc_keyinc, inc_numfol)
	    VALUES
		(wn_cve_emp, ws_cve_con, wn_cve_pro, ws_per_des, ws_cve_dep, ws_cve_pue,
                 ws_fec_mov, wn_can_tid, wn_imp_ort, wn_cer_o,   wn_cer_o,   wn_cer_o,
		 wn_cer_o,   wn_cer_o,   wn_cer_o,   wn_cer_o,   wn_inc_loc,   wn_cer_o );
	    wn_reg_ins := wn_reg_ins + 1;
	    wn_con_reg := wn_con_reg + 1;
	    IF wn_con_reg >= wn_lim_ite THEN
		COMMIT;
		wn_con_reg := 0;
	    END IF;
	END LOOP;
    END IF;
    -- Se inserta en glwkcrys el no. de registros insertados en Incidencias
    INSERT INTO glwkcrys
	(cry_nomrep, cry_idepcc, cry_keyusu, cry_numsec, cry_dec006)
    VALUES
	(ws_nom_rep, ws_ide_pcc, wn_key_usu, 1, wn_reg_ins);
    COMMIT;
    EXCEPTION
	WHEN OTHERS THEN
	    sp_glGenErr (wn_key_usu, ws_ide_pcc, 0, sp_glgethor,
		SQLCODE, 0, SUBSTR (SQLERRM, 1, 60));
END;
/
