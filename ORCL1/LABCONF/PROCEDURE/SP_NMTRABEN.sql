CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABCONF"."SP_NMTRABEN" (vs_tab_ben IN VARCHAR2,vs_tip_pre IN VARCHAR2,vn_key_usu NUMBER )
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
  wn_fec_mov NUMBER(10);
  wn_hor_mov NUMBER(10);
  wn_min_mov NUMBER(10);
  wn_seg_mov NUMBER(10);
  wn_tot_mov NUMBER(16,6);
  ws_tmp_mov VARCHAR2(2);
  --Variables para el traspaso de beneficiarios hacia prestamos
  ws_pre_tmp nmlopres.pre_tippre%TYPE;
  wn_key_emp nmlobebe.beb_keyemp%TYPE;
  ws_key_con nmlobebe.beb_keycon%TYPE;
  ws_tip_ben nmlobebe.beb_tipben%TYPE;
  wn_tip_ben NUMBER(5);
  wn_key_ben nmlobebe.beb_keyben%TYPE;
  wn_por_par nmlobebe.beb_porpar%TYPE;
  wn_imp_fij NUMBER(12,2);
  wn_com_fam nmlobebe.beb_comfam%TYPE;
  ws_per_ini nmlobebe.beb_perini%TYPE;
  ws_per_fin nmlobebe.beb_perfin%TYPE;
  wd_fec_ven nmlobebe.beb_fecven%TYPE;
  ws_for_pag nmlobebe.beb_forpag%TYPE;
  wn_key_pro nmcoempl.emp_keypro%TYPE;
  wn_pla_zop NUMBER(5);
  wn_imp_pre NUMBER(12,2);
  wn_per_ini NUMBER(10);
  wn_per_fin NUMBER(10);
  wn_mov_ant NUMBER(16,6);
  wn_mov_an1 NUMBER(16,6);
  wn_num_sec NUMBER(5);
  wd_fec_ini DATE;
	ws_hor_tem VARCHAR2(8);
BEGIN
  FOR c_tipben IN (
    SELECT pam_folfin, pam_cvesec
      FROM glcopams
     WHERE pam_keypar = vs_tab_ben
       AND  pam_folfin IS NOT NULL
       AND  pam_folfin <> '    ' ) LOOP
    ws_key_con := SUBSTR(c_tipben.pam_folfin,1,3);
    ws_tip_ben := SUBSTR(c_tipben.pam_cvesec,1,2);
    wn_mov_ant := 0;
    wn_mov_an1 := 0;
    FOR c_bene IN (
      SELECT beb_keyemp, beb_tipben, beb_keyben, beb_porpar,
             beb_comfam, beb_perini, beb_fecven, beb_forpag,
             emp_keypro, beb_perfin,beb_impfij,beb_fecini
       FROM nmlobebe, nmcoempl
       WHERE beb_tipben = ws_tip_ben
         AND beb_keyemp = emp_keyemp
         AND ( beb_status IS NULL OR beb_status = ' ' )) LOOP
        wn_key_emp := c_bene.beb_keyemp;
        ws_tip_ben := c_bene.beb_tipben;
        wn_key_ben := c_bene.beb_keyben;
        wn_por_par := c_bene.beb_porpar;
        wn_com_fam := c_bene.beb_comfam;
        ws_per_ini := c_bene.beb_perini;
        wd_fec_ven := c_bene.beb_fecven;
        ws_for_pag := c_bene.beb_forpag;
        wn_key_pro := c_bene.emp_keypro;
        ws_per_fin := c_bene.beb_perfin;
        wn_imp_fij := c_bene.beb_impfij;
        wd_fec_ini := c_bene.beb_fecini;
        -- Obtener la clave unica del prestamo
        sp_glfechor(wn_fec_mov,ws_hor_tem);
        ws_tmp_mov := TO_CHAR(SYSDATE,'HH24');
        wn_hor_mov := ws_tmp_mov;
        ws_tmp_mov := TO_CHAR(SYSDATE,'MI');
        wn_min_mov := ws_tmp_mov;
        ws_tmp_mov := TO_CHAR(SYSDATE,'SS');
        wn_seg_mov := ws_tmp_mov;
        wn_tot_mov := ((wn_hor_mov*3600) +
                         (wn_min_mov*60) + wn_seg_mov)/100000;
        wn_tot_mov := wn_fec_mov + wn_tot_mov;
        wn_per_ini := ws_per_ini;
        wn_per_fin := ws_per_fin;
--        wn_pla_zop := wn_per_fin - wn_per_ini;
        wn_pla_zop := 1;
        wn_imp_pre := wn_por_par * wn_pla_zop;
        IF wn_mov_ant = wn_tot_mov THEN
          wn_tot_mov := wn_tot_mov + .000010;
        END IF;
        IF wn_mov_ant > wn_tot_mov THEN
          wn_tot_mov := wn_tot_mov + .000020;
        END IF;
        wn_mov_ant := wn_tot_mov;
        wn_tip_ben := ws_tip_ben;
        INSERT INTO nmlopres
            ( pre_keyemp, pre_keycon, pre_keypre, pre_refere, pre_fecreg,
              pre_tippre,
              pre_unipre, pre_imppre, pre_gastos, pre_plazop, pre_unides,
              pre_porint, pre_impdes, pre_perini, pre_fecini, pre_fecaut,
              pre_cveaut, pre_fechab, pre_uniamo, pre_impamo, pre_unisal,
              pre_impsal, pre_uniult, pre_impult, pre_numpag, pre_intpag,
              pre_status, pre_ultact, pre_refcon, pre_ctreve, pre_fe1aux,
              pre_fe2aux, pre_ca1aux, pre_ca2aux, pre_ca3aux, pre_ca4aux,
              pre_uniope, pre_keypro )
           VALUES
            ( wn_key_emp, ws_key_con , wn_tot_mov, ws_tip_ben, TO_DATE(wn_fec_mov),
              vs_tip_pre,
              wn_key_ben, wn_com_fam , 0 		 , wn_tip_ben , 0            ,
              wn_por_par, wn_imp_fij , ws_per_ini, wd_fec_ini, TO_DATE(wn_fec_mov)   ,
              vn_key_usu, null       , 0         , 0          , wn_key_ben   ,
              wn_com_fam, 0          , 0         , 0          , 0            ,
              2         , TO_DATE(wn_fec_mov),NULL       , NULL       , wd_fec_ven   ,
              NULL      , NULL       ,NULL       , ws_per_ini , NULL         ,
              0         , wn_key_pro );
    END LOOP;
    UPDATE nmlobebe SET beb_status = 'T'
       WHERE beb_tipben = ws_tip_ben
         AND (beb_status IS NULL OR beb_status = ' ');
    COMMIT;
 END LOOP;
END;
/
