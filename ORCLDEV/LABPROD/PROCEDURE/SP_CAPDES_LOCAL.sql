CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SP_CAPDES_LOCAL" (empleado IN INTEGER, capacidad OUT NUMBER ) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
      PRAGMA AUTONOMOUS_TRANSACTION;
-----------------------------------globales
      wd_salmes         DECIMAL(14,6);
      wi_keypro         INTEGER;
      ws_tipemp         VARCHAR2(6);
      wn_sal_mes        DECIMAL(14,6);
      gn_vales_patpaa   DECIMAL(14,6);
      gd_topevales      DECIMAL(18,2);
      gd_otrasper       DECIMAL(14,6);
      gd_excsal         DECIMAL(14,6);
      ws_apoemp        VARCHAR2(5);--opci
      gs_pagoneto      VARCHAR2(20);--opcis
--------------------------------------------------
      text14            DECIMAL(14,6);
      txtpocentaje      DECIMAL(14,6);
      txtcuotafija      DECIMAL(14,6);
      wd_OtrasFracc     DECIMAL(14,6);
      wd_FraccionI      DECIMAL(14,6);
-----------------------------------locales
      wi_diaper         INTEGER;
      ws_ca2aux         DECIMAL(14,6);
      ws_keycia         VARCHAR2(5);
      ws_keyloc         VARCHAR2(16);
      emp_saldia        DECIMAL(14,6);
      srecurp           VARCHAR2(20);
      wd_impdes         DECIMAL(12,2);
      wi_per_mes        INTEGER;
      ws_keycon         VARCHAR2(8);
      wd_impsal         NUMBER(14,2);
   --patpaa
      wd_eleuno        DECIMAL(18,6);
      wd_eledos        DECIMAL(18,6);
      wd_eletre        DECIMAL(18,6);
      wd_elecua        DECIMAL(18,6);
      i_ban_dera      VARCHAR2(10);
      wd_salminx5      DECIMAL(18,2);
      ws_val_par01     VARCHAR2(30);
      ws_val_par02     VARCHAR2(30);
      wd_topepagovales DECIMAL(14,6);
      wi_cvezon        INTEGER;
      wx_neto_patpaa    DECIMAL(14,6);
      ws_pue_nu1aux     VARCHAR2(10);
   ----------------------------------final
   vn_por_vale          DECIMAL(14,6);
   ----------------------------------ispt
   wn_sal_bas           DECIMAL(14,6);
   wx_dif_sal           DECIMAL(14,6);
   wx_por_cen           DECIMAL(14,6);
   wx_ispt              DECIMAL(14,6);
   wn_ispt           DECIMAL(14,6);
   wx_sub_sidio  DECIMAL(14,6);
   wx_cuota_fija DECIMAL(14,6);
    ----------------------------------imss
    wn_sal_int     DECIMAL(14,6);
    wn_sal_minx3     DECIMAL(14,6);
   wn_imp_ramas     DECIMAL(14,6);
   wn_imp_rama3     DECIMAL(14,6);
   wn_cuota_imss    DECIMAL(14,6);
   --------------------------------------cd
   wn_otr_percep     DECIMAL(14,6);
   wn_otr_per     DECIMAL(14,6);
   wd_capasidaddesc  DECIMAL(14,2);
   tx_tot_dec        DECIMAL(14,6);
   wn_exc_sal       DECIMAL(14,6);
   ValorCompara      DECIMAL(14,6);
--validaci?n
    status   INTEGER;
    wn_tot_reg  INTEGER;
    capacidad_actual DECIMAL (14,2);
    fecing DATE;
    dias DECIMAL(14,2);
    Call_Final integer;
BEGIN
  wd_capasidaddesc := 0;
  EXECUTE IMMEDIATE 'ALTER SESSION SET nls_territory = ''AMERICA''';
  EXECUTE IMMEDIATE 'ALTER SESSION SET nls_language = ''AMERICAN''';
  EXECUTE IMMEDIATE 'ALTER SESSION SET nls_date_format = ''dd/mm/yyyy''';
  SELECT emp_salmes, emp_keypro, emp_tipemp, pro_diaper, nvl(sp_todecimal2(cia_ca2aux),0), cia_keycia, emp_keyloc, emp_saldia, emp_recurp, emp_salint, nvl(substr(pro_nu3aux, 3, 1), 0), emp_status, emp_fecaux
  INTO wd_salmes, wi_keypro, ws_tipemp, wi_diaper, ws_ca2aux, ws_keycia, ws_keyloc, emp_saldia, srecurp, wn_sal_int, i_ban_dera, status, fecing
  FROM LABPROD.nmcoempl
  inner join LABPROD.nmloproc on (emp_keypro = pro_keypro)
  inner join LABPROD.nmlocias on (pro_keycia = cia_keycia)
  WHERE emp_keyemp = empleado;
  IF status != 1 THEN
  BEGIN
    capacidad := 0; COMMIT; RETURN;
  END;
  END IF;
  select count(*) into wn_tot_reg From LABPROD.nmlopres
  Where pre_keyemp = empleado
  AND pre_status = '2'
  AND pre_keycon IN ('307','308','309')
  AND trunc(sysdate) >= pre_fecini
  AND trunc(sysdate) <= pre_fe1aux;
  IF wn_tot_reg > 0 THEN
    capacidad := 0; RETURN;
  END IF;
  UPDATE LABPROD.tvcapdes SET pde_recurp = srecurp WHERE pde_keyemp = empleado;
  wn_sal_mes  := wd_salmes;
  wi_per_mes := floor(30/wi_diaper);
  --opcises
  SELECT pam_folini INTO gs_pagoneto FROM LABPROD.glcopams
  WHERE pam_keypar = (SELECT pam_folini FROM LABPROD.glcopams WHERE pam_keypar = '00' AND pam_cvesec = 'caprec')
  AND pam_nompar = 'Pago Neto';
  SELECT pam_folini INTO ws_apoemp FROM LABPROD.glcopams
  WHERE pam_keypar = (SELECT pam_folini FROM LABPROD.glcopams WHERE pam_keypar = '00' AND pam_cvesec = 'caprec')
  AND pam_nompar ='Aportacion Empleado';
  BEGIN
    FOR q_dfi IN
      (SELECT dfi_perfin,dfi_cantid, dfi_import
        FROM LABPROD.nmlodfij
        inner join LABPROD.nmcoempl on (dfi_keyemp = emp_keyemp and dfi_keypro = emp_keypro)
        WHERE dfi_keyemp = empleado
        AND dfi_keycon = ws_apoemp
        AND (dfi_ca2aux is null OR dfi_ca2aux ='')
        ORDER BY dfi_perfin DESC) LOOP
      txtpocentaje := q_dfi.dfi_cantid;
      txtcuotafija := q_dfi.dfi_import;
      EXIT;
    END LOOP;
    EXCEPTION WHEN NO_DATA_FOUND THEN txtpocentaje := 0.0; txtcuotafija := 0.0;
  END;
  Text14 := 0;
  IF txtpocentaje > 0 THEN
    Text14 := 0;
  END IF;
  IF txtcuotafija > 0 THEN
    Text14 := txtcuotafija * wi_per_mes;
  END IF ;
  wd_impdes := 0;
  select nvl(sum(pre_impdes), 0) * wi_per_mes into wd_impdes from (
  SELECT pre_impdes FROM LABPROD.nmlopres, LABPROD.nmloconc, LABPROD.glcopams
  WHERE pre_keycon = con_keycon
  AND pre_status IN (1, 2)
  AND pre_keycon not in (SELECT pam_folini from LABPROD.glcopams where pam_keypar = 'SAFC')
  AND pre_impsal > 0
  AND pre_keypro = wi_keypro
  AND pre_keycon = pam_cvesec
  AND pam_keypar = 'IFI'
  AND pre_keyemp = empleado
  UNION ALL
  SELECT SUM(pre_ca3aux) pre_impdes
  FROM LABPROD.nmlopres, LABPROD.nmloconc, LABPROD.glcopams
  WHERE pre_keycon = con_keycon
  AND pre_status IN (1, 2)
  AND pre_keycon in(SELECT pam_folini from LABPROD.glcopams where pam_keypar = 'SAFC')
  AND pre_impsal > 0
  AND pre_keypro = wi_keypro
  AND pre_keycon = pam_cvesec
  AND pam_keypar = 'IFI'
  AND pre_keyemp = empleado
  AND pre_ca3aux IS NOT NULL
  );
  SP_ACUM(empleado, wd_impsal);
  SELECT nvl(sum(dfi_import * (decode(pro_diaper, 15, 2, 10, 3, 7, 4))),0) INTO wd_OtrasFracc
  FROM LABPROD.nmlodfij, LABPROD.nmloproc, LABPROD.nmlocxpr, LABPROD.glcopams
  WHERE dfi_keyemp = empleado
  AND dfi_keypro = pro_keypro
  AND dfi_keycon = cxp_keycon
  AND cxp_keypro = wi_keypro
  AND cxp_keynom = 1
  AND cxp_leedfi = 'S'
  AND cxp_keycon = pam_cvesec
  AND pam_keypar = 'DFI'
  AND cxp_keycon Not IN (SELECT acu_keycon
        FROM LABPROD.nmloacum, LABPROD.glcopams
        WHERE acu_keyemp = empleado
        AND acu_keycon = pam_cvesec
        AND pam_keypar = 'DFI');
  SELECT nvl(sum(dfi_import * (decode(pro_diaper, 15, 2, 10, 3, 7, 4))),0) INTO wd_FraccionI
  FROM LABPROD.nmlodfij, LABPROD.nmloproc, LABPROD.nmlocxpr, LABPROD.glcopams
  WHERE dfi_keyemp = empleado
  AND dfi_keypro = pro_keypro
  AND dfi_keycon = cxp_keycon
  AND cxp_keypro = wi_keypro
  AND cxp_keynom = 1
  AND cxp_keycon = pam_cvesec
  AND pam_keypar = 'IFI'
  AND cxp_keycon <> 'D63';
  ------------------------------------------------------------------
   -->>>>>>>>>>>>>>'Calculo el PATPAA<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
   --  CALL Calcula_Patpaa(wd_salmes, wi_keypro, ws_tipemp, gd_neto_patpaa, wn_otr_percep)
  wx_neto_patpaa := 0;
  wd_topepagovales := 0;
  IF i_ban_dera = 1 THEN
    ws_val_par01 := 0;
    ws_val_par02 := 0;
    BEGIN--'clave de Patpaa con clave 01 de datos adicionales o importe
      SELECT nvl(dat_valpar,0) INTO ws_val_par01 FROM LABPROD.nmlodata
      WHERE dat_keyemp = empleado AND dat_keypar = '01';
      EXCEPTION WHEN NO_DATA_FOUND THEN ws_val_par01 := 0;
    END;
    BEGIN--'clave de Patpaa con clave 02 de datos adicionales
      SELECT nvl(dat_valpar,0) INTO ws_val_par02 FROM LABPROD.nmlodata
      WHERE dat_keyemp =  empleado AND dat_keypar = '02';
      EXCEPTION WHEN NO_DATA_FOUND THEN ws_val_par02 := 0;
    END;
    SELECT trim(nvl(pue_nu1aux,0)) INTO ws_pue_nu1aux --'Clave de Patpaa seg?n puesto de empleado
      FROM LABPROD.nmcoempl
      INNER JOIN nmcopues ON (emp_keypue = pue_keypue)
      WHERE emp_keyemp = empleado;
    IF wi_keypro = 11 Or wi_keypro = 15 THEN --'Tope Vales (hasta 5 salarios minimos)
      SELECT nvl(tab_eledos,0) INTO gd_topevales FROM LABPROD.nmcoempl, LABPROD.nmlotabn
      WHERE emp_cvezon = tab_eleuno AND tab_keytab= '002' AND emp_keyemp = empleado;
    ELSE
      SELECT tab_eledos INTO wd_salminx5 FROM LABPROD.nmcoempl, LABPROD.nmlotabn
      WHERE emp_cvezon = tab_eleuno AND tab_keytab= '019' AND emp_keyemp = empleado;
      wd_salminx5 := wd_salminx5 * 5;
      gd_topevales := wd_salminx5 * 30.4;
    END IF;
    BEGIN
		SELECT tab_eleuno, tab_eledos, tab_eletre, tab_elecua, emp_cvezon  INTO wd_eleuno, wd_eledos, wd_eletre, wd_elecua, wi_cvezon
		FROM LABPROD.nmcoempl, LABPROD.nmlotabn
		WHERE emp_keypro = tab_eleuno
		AND tab_keytab= '053' AND emp_keyemp = empleado AND emp_status = 1;
      EXCEPTION WHEN NO_DATA_FOUND THEN wd_eleuno := 0; wd_eledos := 0; wd_eletre := 0; wd_elecua := 0;
    END;
    IF wd_eleuno = 15 THEN
      IF wi_cvezon = 1 THEN
        wd_topepagovales := wd_eledos;
      END IF;
      IF wi_cvezon = 2 THEN
        wd_topepagovales := wd_eletre;
      END IF;
    ELSE
      IF ws_tipemp = 1 THEN
        wd_topepagovales := wd_eledos;
      END IF;
      IF ws_tipemp = 2 THEN
        wd_topepagovales := wd_eletre;
      END IF;
    END IF;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
    --El c?digo para el c?lculo de PATPAA se copio exactamente del c?digo del programa tvcdepre
    --El llamado a la funci?n Final Call Final(wx_neto_patpaa, wx_tope_pago_vales, wx_vales_patpaa)
    -- se sustituyo por Call_Final = 0
    -- El codigo equivalente de la funcion Final en VB se ejecuta al final del bloque
    --INICIA BLOQUE COPIADO DE VB tvcdepre
    wx_neto_patpaa := 0;
    If ws_val_par01 = '9' Then
      Call_Final := 0;
    Else
      If CAST(ws_val_par01 AS NUMBER) > 100 Then     --importe en datos adicionales
        wx_neto_patpaa := CAST(ws_val_par01 AS NUMBER);
        If ws_val_par02 = '0' Then
          Call_Final := 0;
        Else
          If wi_keypro <> 3 Then
            BEGIN
              SELECT tab_eleuno,tab_eledos,tab_eletre,tab_elecua
                INTO wd_eleuno, wd_eledos, wd_eletre, wd_elecua
                FROM LABPROD.nmlotabn
                WHERE Tab_eleuno = CAST(ws_val_par02 AS NUMBER)
                  AND  tab_keytab= '024';
              EXCEPTION WHEN NO_DATA_FOUND THEN wd_eleuno := 0; wd_eledos := 0; wd_eletre := 0; wd_elecua := 0;
            END;
            wx_neto_patpaa := wx_neto_patpaa + wd_eledos;
          Else
            BEGIN
              SELECT tab_eleuno,tab_eledos,tab_eletre,tab_elecua
                INTO wd_eleuno, wd_eledos, wd_eletre, wd_elecua
                FROM LABPROD.nmlotabn
                WHERE Tab_eleuno = CAST(ws_val_par02 AS NUMBER)
                  AND  tab_keytab= '009';
              EXCEPTION WHEN NO_DATA_FOUND THEN wd_eleuno := 0; wd_eledos := 0; wd_eletre := 0; wd_elecua := 0;
            END;
            wx_neto_patpaa := wx_neto_patpaa + wd_eledos;
          End if;
          Call_Final := 0;
        End if;
      ELSE
        If wi_keypro = 17 Then --Intermex
          Call_Final := 0;
        Else
          If ws_val_par01 = '0' Then
            If ws_pue_nu1aux = '0' Then
              If ws_val_par02 = '0' Then
                Call_Final := 0;
              Else
                If wi_keypro <> 3 Then
                  BEGIN
                    SELECT tab_eleuno,tab_eledos,tab_eletre,tab_elecua
                      INTO wd_eleuno, wd_eledos, wd_eletre, wd_elecua
                      FROM LABPROD.nmlotabn
                      WHERE Tab_eleuno = CAST(ws_val_par02 AS NUMBER)
                        AND  tab_keytab= '024';
                    EXCEPTION WHEN NO_DATA_FOUND THEN wd_eleuno := 0; wd_eledos := 0; wd_eletre := 0; wd_elecua := 0;
                  END;
                  wx_neto_patpaa := wx_neto_patpaa + wd_eledos;
                Else
                  BEGIN
                    SELECT tab_eleuno,tab_eledos,tab_eletre,tab_elecua
                      INTO wd_eleuno, wd_eledos, wd_eletre, wd_elecua
                      FROM LABPROD.nmlotabn
                      WHERE Tab_eleuno = CAST(ws_val_par02 AS NUMBER)
                        AND  tab_keytab= '009';
                    EXCEPTION WHEN NO_DATA_FOUND THEN wd_eleuno := 0; wd_eledos := 0; wd_eletre := 0; wd_elecua := 0;
                  END;
                  wx_neto_patpaa := wx_neto_patpaa + wd_eledos;
                End if;
                Call_Final := 0;  /* AQUI */
              End if;
            Else
              If wi_keypro <> 3 Then
                BEGIN
                  SELECT tab_eleuno,tab_eledos,tab_eletre,tab_elecua
                    INTO wd_eleuno, wd_eledos, wd_eletre, wd_elecua
                    FROM LABPROD.nmlotabn
                    WHERE Tab_eleuno = CAST(ws_pue_nu1aux AS NUMBER)
                      AND  tab_keytab= '024';
                  EXCEPTION WHEN NO_DATA_FOUND THEN wd_eleuno := 0; wd_eledos := 0; wd_eletre := 0; wd_elecua := 0;
                END;
                wx_neto_patpaa := wx_neto_patpaa + wd_eledos;
              Else
                BEGIN
                  SELECT tab_eleuno,tab_eledos,tab_eletre,tab_elecua
                    INTO wd_eleuno, wd_eledos, wd_eletre, wd_elecua
                    FROM LABPROD.nmlotabn
                    WHERE Tab_eleuno = CAST(ws_pue_nu1aux AS NUMBER)
                      AND  tab_keytab= '009';
                  EXCEPTION WHEN NO_DATA_FOUND THEN wd_eleuno := 0; wd_eledos := 0; wd_eletre := 0; wd_elecua := 0;
                END;
                wx_neto_patpaa := wx_neto_patpaa + wd_eledos;
              End if;
              Call_Final := 0;  /* AQUI */
            End if;
          Else
            If wi_keypro <> 3 Then
              BEGIN
                SELECT tab_eleuno,tab_eledos,tab_eletre,tab_elecua
                  INTO wd_eleuno, wd_eledos, wd_eletre, wd_elecua
                  FROM LABPROD.nmlotabn
                  WHERE Tab_eleuno = CAST(ws_val_par01 AS NUMBER)
                    AND  tab_keytab= '024';
                EXCEPTION WHEN NO_DATA_FOUND THEN wd_eleuno := 0; wd_eledos := 0; wd_eletre := 0; wd_elecua := 0;
              END;
              wx_neto_patpaa := wx_neto_patpaa + wd_eledos;
            Else
              BEGIN
                SELECT tab_eleuno,tab_eledos,tab_eletre,tab_elecua
                  INTO wd_eleuno, wd_eledos, wd_eletre, wd_elecua
                  FROM LABPROD.nmlotabn
                  WHERE Tab_eleuno = CAST(ws_val_par01 AS NUMBER)
                    AND  tab_keytab= '009';
                EXCEPTION WHEN NO_DATA_FOUND THEN wd_eleuno := 0; wd_eledos := 0; wd_eletre := 0; wd_elecua := 0;
              END;
              wx_neto_patpaa := wx_neto_patpaa + wd_eledos;
            End if;
            Call_Final := 0;
          End if;
          Call_Final := 0;
        End if;
      End if;
    End if;
    --TERMINA BLOQUE COPIADO DE VB tvcdepre
--	Call Final(wx_neto_patpaa, wd_topepagovales, wd_valespatpaa)
    gd_otrasper := 0;
    IF (wx_neto_patpaa - wd_topepagovales) > 0 THEN
      wx_neto_patpaa := wx_neto_patpaa - wd_topepagovales;
    ELSE
      wx_neto_patpaa := 0;
    END IF;
    IF wd_salmes < gd_topevales THEN
      IF (wi_keypro) >= 28 AND (wi_keypro) <= 52 THEN
          BEGIN
              SELECT tab_eledos/100 into vn_por_vale
              FROM LABPROD.nmlotabn
              WHERE tab_keytab = '032'
              AND tab_eleuno = wi_keypro;
          EXCEPTION WHEN NO_DATA_FOUND THEN vn_por_vale := 0;
          END;
      ELSE
          BEGIN
              SELECT tab_eletre,tab_elecua INTO wd_eletre, wd_elecua
              FROM LABPROD.nmlotabn
              WHERE tab_keytab = '004'
              AND tab_eleuno = ws_keycia;
          EXCEPTION WHEN NO_DATA_FOUND THEN wd_eletre := 0; wd_elecua := 0;
          END;
          IF ws_tipemp = 1 THEN vn_por_vale := wd_eletre / 100; END IF;
          IF ws_tipemp = 2 THEN vn_por_vale := wd_elecua / 100; END IF;
      END IF;
      gd_otrasper := (emp_saldia * 30) * vn_por_vale;
    END IF;
--	Fin Final(wx_neto_patpaa, wd_topepagovales, wd_valespatpaa)
    wn_otr_percep := greatest(gd_otrasper - wd_topepagovales, 0);
  ELSE
      wx_neto_patpaa := 0;
      wn_otr_percep := 0;
  END IF;
   -->>>>>>>>>>>>>>'Calculo el ISPT<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
--   CALL Calcula_Ispt(wd_salmes, wn_dif_sal, wn_ispt, ws_ca2aux, ws_keycia, ws_tipemp, wi_keypro)
  wn_sal_bas := wd_salmes;
  wx_dif_sal := 0;
  IF (wi_keypro) >= 28 AND (wi_keypro) <= 52 THEN
	BEGIN
    SELECT tab_eledos INTO wd_eledos FROM LABPROD.nmlotabn
    WHERE tab_keytab = '030' AND tab_eleuno = wi_keypro;
    EXCEPTION WHEN NO_DATA_FOUND THEN wd_eledos := 0;
  END;
ELSE
	BEGIN
    SELECT tab_eledos into wd_eledos FROM LABPROD.nmlotabn
    WHERE tab_keytab = '014' AND tab_eleuno = ws_keycia;
    EXCEPTION WHEN NO_DATA_FOUND THEN wd_eledos := 0;
  END;
END IF;
	IF wd_eledos is not null THEN
    wn_sal_bas := wn_sal_bas + (wn_sal_bas * (wd_eledos / 100));
  END IF;
	BEGIN
    SELECT min(tab_eleuno), min(tab_eletre), min(tab_elecua), min(tab_eledos) INTO wd_eleuno, wd_eletre, wd_elecua, wd_eledos
    FROM LABPROD.nmlotabn
    WHERE tab_keytab = 'I10' AND tab_eledos > wn_sal_bas ORDER BY tab_eledos;
    EXCEPTION WHEN NO_DATA_FOUND THEN wd_eleuno:=0; wd_eletre:=0; wd_elecua:=0; wd_eledos:=0;
  END;
  IF wd_elecua is not null THEN
		wx_por_cen := wd_elecua / 100;
        wx_dif_sal := (wn_sal_bas - wd_eleuno) * wx_por_cen;
        wx_ispt := wx_dif_sal + wd_eletre;
  END IF;
	BEGIN
    SELECT tab_eleuno, tab_eletre, tab_elecua, tab_eledos INTO wd_eleuno, wd_eletre, wd_elecua, wd_eledos
    FROM LABPROD.nmlotabn
    WHERE tab_keytab = 'I11' AND tab_eledos > wn_sal_bas AND ROWNUM = 1 ORDER BY tab_eledos;
	  EXCEPTION WHEN NO_DATA_FOUND THEN wd_eleuno:=0; wd_eletre:=0; wd_elecua:=0; wd_eledos:=0;
  END;
  IF wd_elecua is not null THEN
        wx_por_cen := wd_elecua / 100;
        wx_dif_sal := wx_dif_sal * wx_por_cen + wd_eletre;
        wx_sub_sidio := wx_dif_sal * (ws_ca2aux / 100);
  END IF;
	BEGIN
    SELECT tab_eleuno, tab_eletre, tab_elecua, tab_eledos INTO wd_eleuno, wd_eletre, wd_elecua, wd_eledos
    FROM LABPROD.nmlotabn
    WHERE tab_keytab = 'I12' AND tab_eledos > wn_sal_bas AND ROWNUM = 1 ORDER BY tab_eledos;
	  EXCEPTION WHEN NO_DATA_FOUND THEN wd_eleuno:=0; wd_eletre:=0; wd_elecua:=0; wd_eledos:=0;
  END;
  IF wd_eletre is not null THEN
        wx_cuota_fija := wd_eletre;
        wx_dif_sal := wx_dif_sal - wx_sub_sidio;
        wx_ispt := wx_ispt - wx_sub_sidio - wx_cuota_fija;
  END IF;
  wn_ispt := greatest(wx_ispt,0);
   -->>>>>>>>>>>>>>'Calcula el IMSS<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
--   CALL Calcula_Imss(vn_key_emp, wn_cuota_imss)
      BEGIN
          SELECT tab_eledos into wd_eledos
          FROM LABPROD.nmlotabn
          WHERE tab_keytab = '002'
          AND tab_eleuno = 1;
      EXCEPTION WHEN NO_DATA_FOUND THEN wd_eledos := 0;
      END;
      wn_sal_minx3 := wd_eledos * 3;
      BEGIN
          SELECT sum(tab_eletre/100) into wd_eletre
          FROM LABPROD.nmlotabn
          WHERE tab_keytab = '005'
          AND tab_eleuno In (1,4,5,7);
      EXCEPTION WHEN NO_DATA_FOUND THEN wd_eletre := 0;
      END;
      wn_imp_ramas := wn_sal_int * wd_eletre;
      BEGIN
          SELECT sum(tab_eletre/100) into wd_eletre
          FROM LABPROD.nmlotabn
          WHERE tab_keytab = '005'
          AND tab_eleuno In (3);
      EXCEPTION WHEN NO_DATA_FOUND THEN wd_eletre := 0;
      END;
      wn_cuota_imss := 0;
      dias := fecing - TO_DATE('19000101','YYYYMMDD');
      IF ws_tipemp = '1' THEN
        if (wd_salmes > 132500 or ( fecing - TO_DATE('19000101','YYYYMMDD') > 37864 )) then
            wn_imp_rama3 := greatest(wn_sal_int - wn_sal_minx3,0) * wd_eletre;
            wn_cuota_imss := (wn_imp_ramas + wn_imp_rama3) * 30;
        end if;
      END IF;
--   CALL ValorCapacidadDes(wd_salmes, wi_keypro, ws_keycia, wd_impdes)
   wn_otr_per := 0;
    BEGIN
      SELECT (tab_eledos * 30) INTO wd_eledos
      FROM LABPROD.nmcoempl, LABPROD.nmlotabn
      WHERE emp_cvezon = tab_eleuno
        AND tab_keytab= '002'
        AND emp_keyemp = empleado;
    EXCEPTION WHEN NO_DATA_FOUND THEN wd_eledos := 0;
    END;
   wn_exc_sal := wd_eledos;
   --'Extrae los porcentaje de PIPS
   ------------------------------PIPS---------------------
   IF (wi_keypro) >= 28 AND (wi_keypro) <= 52 THEN
      BEGIN
        SELECT tab_eletre INTO wd_eledos FROM LABPROD.nmlotabn
        WHERE tab_keytab = '030' AND tab_eleuno = wi_keypro;
      EXCEPTION WHEN NO_DATA_FOUND THEN wd_eledos := 0;
      END;
   ELSE
      BEGIN
        SELECT tab_eledos INTO wd_eledos FROM LABPROD.nmlotabn
        WHERE tab_keytab = '003' AND tab_eleuno = ws_keycia;
        EXCEPTION WHEN NO_DATA_FOUND THEN wd_eledos := 0;
      END;
   END IF;
   wn_otr_per := wn_otr_per + (wd_salmes * (wd_eledos/ 100));
   --'--------------------------------FIN PIPS---------------------
   --'----------------------------FOMENTO EFICIENCIA---------------------
   IF (wi_keypro) >= 28 AND (wi_keypro) <= 52 THEN
        BEGIN
        SELECT tab_eledos INTO wd_eledos FROM LABPROD.nmlotabn
        WHERE tab_keytab = '030' AND tab_eleuno = wi_keypro;
        EXCEPTION WHEN NO_DATA_FOUND THEN wd_eledos := 0;
        END;
   ELSE
        BEGIN
          SELECT tab_eledos INTO wd_eledos FROM LABPROD.nmlotabn
          WHERE tab_keytab = '014' AND tab_eleuno = ws_keycia;
          EXCEPTION WHEN NO_DATA_FOUND THEN wd_eledos := 0;
        END;
   END IF;
   wn_otr_per := wn_otr_per + (wn_sal_mes * (wd_eledos / 100)) + wx_neto_patpaa + wn_otr_percep; -- wn_otr_percep viene de patpaa
   gd_excsal := (wd_salmes + wn_otr_per - wn_exc_sal) * 0.3;
   tx_tot_dec := least(greatest(gd_excsal - wd_impdes, 0),gd_excsal);
   ValorCompara := wd_salmes - wd_impdes - wd_impsal - wn_ispt - wn_cuota_imss - wd_OtrasFracc - wd_FraccionI - text14;
   IF tx_tot_dec < ValorCompara THEN
      wd_capasidaddesc := tx_tot_dec;
   END IF;
      BEGIN
        SELECT pde_capnew into capacidad_actual FROM LABPROD.tvcapdes WHERE pde_keyemp = empleado;
            IF wd_capasidaddesc <> capacidad_actual THEN
                UPDATE LABPROD.tvcapdes
                SET pde_fecant = pde_fecmov, pde_capant = pde_capnew, pde_horant = pde_hormov, pde_hormov = to_char(sysdate, 'HH:MM'),
                  pde_fecmov = sysdate, pde_capnew = wd_capasidaddesc, pde_status = 1
                WHERE pde_keyemp = empleado;
            END IF;
        EXCEPTION
        WHEN NO_DATA_FOUND THEN INSERT INTO LABPROD.tvcapdes VALUES (empleado, srecurp, sysdate,0,sysdate,0,0,'00:00',to_char(sysdate, 'HH:MM'));
      END;
   capacidad := wd_capasidaddesc;
    --capacidad := ws_val_par01;
   commit;
END;
/
