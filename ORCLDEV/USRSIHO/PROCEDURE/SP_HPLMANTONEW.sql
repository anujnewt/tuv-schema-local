CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_HPLMANTONEW" (s_idepro VARCHAR2, s_idepcc VARCHAR2,
                             i_keyusu number, i_accion NUMBER, numplaza out number) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
-- ---------------------------------------------------------------------------------------------------------
-- Variables de Trabajo
   wn_max_arr NUMBER(10);
   wn_j NUMBER(10);
   wi_numplz number(10);
   wn_inicio NUMBER(10);
   wn_max_plz NUMBER(10);
   wn_ult_plz NUMBER(10);
   wi_primer NUMBER(10) ;
   wn_i NUMBER(10);
   gn_totcap  NUMBER(10);
   i_totcap   NUMBER(10) ;
   wn_valsta  NUMBER(10);
   gs_keyact  VARCHAR2 (16);
   gs_key_act VARCHAR2 (16);
   gs_des_act VARCHAR2 (40);
   gn_cos_tot NUMBER(10);
   wn_num_plz NUMBER(10);
   gs_keypro  VARCHAR2 (16);
   gs_keyproT VARCHAR2 (16);
   gs_key_pro VARCHAR2 (16);
   wn_valida  NUMBER(10);
   tx_fec_ini VARCHAR2 (10);
   ws_plazaprimaria VARCHAR2 (02);
   ws_excepcion VARCHAR2 (02);
   i_movpla20 NUMBER(10);
   i_movpla18 NUMBER(10);
   gn_presup  NUMBER(10);
   ws_valaux  VARCHAR2 (16);
   i_busca    NUMBER(10);
   w_status   NUMBER(10);
   wn_montomax NUMBER(10);
BEGIN
-- ---------------------------------------------------------------------------------------------------------
-- Limpia variables de trabajo
 numplaza := 0;
IF i_accion = 1 THEN -- Inserta
    BEGIN
       SELECT arg_keycam
       into gs_key_act
       FROM USRSIHO.glcoargu
       WHERE arg_idepro = s_idepro
       AND arg_idepcc = s_idepcc
       AND arg_keyusu = i_keyusu
       AND arg_pvalor = 'ALTA'
       AND arg_descam = 'gs_key_act';
       EXCEPTION WHEN no_data_found THEN gs_key_act := '';
    END;
    BEGIN
       SELECT arg_keycam
       into gs_des_act
       FROM USRSIHO.glcoargu
       WHERE arg_idepro = s_idepro
       AND arg_idepcc = s_idepcc
       AND arg_keyusu = i_keyusu
       AND arg_pvalor = 'ALTA'
       AND arg_keycam = 'gs_des_act';
       EXCEPTION WHEN no_data_found THEN gs_des_act := '';
    END;
--       SELECT arg_keycam
--       into gn_cos_tot
--       FROM USRSIHO.glcoargu
--       WHERE arg_idepro = s_idepro
--       AND arg_idepcc = s_idepcc
--       AND arg_keyusu = i_keyusu
--       AND arg_pvalor = 'ALTA'
--       AND arg_descam = 'gn_cos_tot';
    BEGIN
       SELECT arg_keycam
       into ws_plazaprimaria
       FROM USRSIHO.glcoargu
       WHERE arg_idepro = s_idepro
       AND arg_idepcc = s_idepcc
       AND arg_keyusu = i_keyusu
       AND arg_pvalor = 'ALTA'
       AND arg_descam = 'ws_plazaprimaria';
       EXCEPTION WHEN no_data_found THEN ws_plazaprimaria := '';
    END;
    BEGIN
       SELECT arg_keycam
       into ws_excepcion
       FROM USRSIHO.glcoargu
       WHERE arg_idepro = s_idepro
       AND arg_idepcc = s_idepcc
       AND arg_keyusu = i_keyusu
       AND arg_pvalor = 'ALTA'
       AND arg_descam = 'ws_excepcion';
       EXCEPTION WHEN no_data_found THEN ws_excepcion := '';
    END;
    BEGIN
       SELECT arg_keycam
       into wn_num_plz
       FROM USRSIHO.glcoargu
       WHERE arg_idepro = s_idepro
       AND arg_idepcc = s_idepcc
       AND arg_keyusu = i_keyusu
       AND arg_pvalor = 'ALTA'
       AND arg_descam = 'wn_num_plz';
       EXCEPTION WHEN no_data_found THEN wn_num_plz := 0;
    END;
--       SELECT arg_keycam
--       into wn_valida
--       FROM USRSIHO.glcoargu
--       WHERE arg_idepro = s_idepro
--       AND arg_idepcc = s_idepcc
--       AND arg_keyusu = i_keyusu
--       AND arg_pvalor = 'ALTA'
--       AND arg_descam = 'wn_valida';
    BEGIN
       SELECT arg_keycam
       into tx_fec_ini
       FROM USRSIHO.glcoargu
       WHERE arg_idepro = s_idepro
       AND arg_idepcc = s_idepcc
       AND arg_keyusu = i_keyusu
       AND arg_pvalor = 'ALTA'
       AND arg_descam = 'tx_fec_ini';
       EXCEPTION WHEN no_data_found THEN tx_fec_ini := '';
    END;
    BEGIN
       SELECT arg_keycam
       into gs_key_pro
       FROM USRSIHO.glcoargu
       WHERE arg_idepro = s_idepro
       AND arg_idepcc = s_idepcc
       AND arg_keyusu = i_keyusu
       AND arg_pvalor = 'ALTA'
       AND arg_descam = 'gs_key_pro';
       EXCEPTION WHEN no_data_found THEN gs_key_pro := '';
    END;
       IF wn_valida = 1 THEN
            BEGIN
                  SELECT arg_keycam, arg_descam
                  into wi_primer, wn_j
                  FROM USRSIHO.glcoargu
                  WHERE arg_idepro = s_idepro
                  AND arg_idepcc = s_idepcc
                  AND arg_keyusu = i_keyusu
                  AND arg_pvalor = 'ARREGLO';
                  EXCEPTION WHEN no_data_found THEN wi_primer := 0; wn_j := 0;
            END;
       ELSE
          wi_primer := 0;
          wn_j := 0;
       END IF;
--       SELECT arg_keycam
--       into gn_totcap
--       FROM USRSIHO.glcoargu
--       WHERE arg_idepro = s_idepro
--       AND arg_idepcc = s_idepcc
--       AND arg_keyusu = i_keyusu
--       AND arg_pvalor = 'ALTA'
--       AND arg_descam = 'gn_totcap';
    BEGIN
       SELECT arg_keycam
       into wn_montomax
       FROM USRSIHO.glcoargu
       WHERE arg_idepro = s_idepro
       AND arg_idepcc = s_idepcc
       AND arg_keyusu = i_keyusu
       AND arg_pvalor = 'ALTA'
       AND arg_descam = 'wn_montomax';
       EXCEPTION WHEN no_data_found THEN wn_montomax := 0;
    END;
    FOR wn_inicio in 1 .. wn_num_plz loop
      wn_max_plz := 1; ---Ctvo.Plz. Disponible
    ---Inserta la Plaza, indicando el Usuario que la genera
      INSERT INTO USRSIHO.holoplza (plz_keyfol, plz_keytco, plz_keydep,
                            plz_keypue, plz_keyemp, plz_numcap, plz_capini,
                            plz_capfin, plz_keytab, plz_cosuni, plz_keytva,
                            plz_status, plz_fecini, plz_fecalt, plz_keyusg,
                            plz_hrsmod, plz_mtomax,plz_mtoeje,plz_primaria,plz_excep,plz_asig)
                    VALUES (null, null, gs_key_pro,
                            gs_key_act, null, null, wi_primer,
                            wn_j, null, 0, 0,
                            0, tx_fec_ini, trunc(sysdate), i_keyusu,
                            null,wn_montomax,null,ws_plazaprimaria,ws_excepcion,0);
--wn_ult_plz :=  sp_lee_serial();
      SELECT MAX(plz_ctvplz)
       INTO   wn_ult_plz
       FROM   USRSIHO.holoplza;
      --select max(plz_ctvplz)
      --into wn_ult_plz
      ---from holoplza;
      --IF wn_ult_plz = 0 THEN
      --   LET wn_ult_plz = 1;
      --END IF;
    END LOOP;
--RETURN wn_ult_plz;
END IF;
IF i_accion = 2  THEN -- Borra
    BEGIN
       SELECT arg_keycam
       into gs_keyact
       FROM USRSIHO.glcoargu
       WHERE arg_idepro = s_idepro
       AND arg_idepcc = s_idepcc
       AND arg_keyusu = i_keyusu
       AND arg_pvalor = 'BAJA'
       AND arg_descam = 'gs_keyact';
       EXCEPTION WHEN no_data_found THEN gs_keyact := '';
    END;
    BEGIN
       SELECT substr(arg_keycam,1,6),arg_keycam
       into gs_keypro, gs_keyproT
       FROM USRSIHO.glcoargu
       WHERE arg_idepro = s_idepro
       AND arg_idepcc = s_idepcc
       AND arg_keyusu = i_keyusu
       AND arg_pvalor = 'BAJA'
       AND arg_descam = 'gs_keypro';
       EXCEPTION WHEN no_data_found THEN gs_keypro := ''; gs_keyproT := '';
    END;
    BEGIN
       SELECT arg_keycam
       into ws_valaux
       FROM USRSIHO.glcoargu
       WHERE arg_idepro = s_idepro
       AND arg_idepcc = s_idepcc
       AND arg_keyusu = i_keyusu
       AND arg_pvalor = 'BAJA'
       AND arg_descam = 'ws_valaux';
       EXCEPTION WHEN no_data_found THEN ws_valaux := '';
    END;
    BEGIN
       SELECT arg_keycam
       into wi_numplz
       FROM USRSIHO.glcoargu
       WHERE arg_idepro = s_idepro
       AND arg_idepcc = s_idepcc
       AND arg_keyusu = i_keyusu
       AND arg_pvalor = 'BAJA'
       AND arg_descam = 'wi_numplz';
       EXCEPTION WHEN no_data_found THEN wi_numplz := 0;
    END;
        BEGIN
            SELECT plz_status
            INTO w_status
            FROM USRSIHO.holoplza
            WHERE plz_ctvplz = wi_numplz
            AND plz_asig = ws_valaux;
            EXCEPTION WHEN no_data_found THEN w_status := 0;
        END;
      IF w_status = 1 THEN
-- CODIGO QUE ACTUALIZA EL PRESUPUESTO EJERCIDO = Presupuesto Ejercido - Costo de la Plaza
--         UPDATE hologlpr set glp_ejerci = glp_ejerci - gn_presup
--         WHERE glp_keydep = gs_keypro
--         AND glp_keypue = gs_keyact;
         UPDATE USRSIHO.holoplza set plz_status =0
         WHERE plz_ctvplz = wi_numplz
         AND plz_keydep = gs_keyproT AND plz_asig = ws_valaux;
      ELSE
         IF w_status = 0 Then
            insert into USRSIHO.glwkcrys  (cry_nomrep,cry_numsec,cry_chr001 ) values ('claudia',1,ws_valaux);
            insert into USRSIHO.glwkcrys  (cry_nomrep,cry_numsec,cry_chr001 ) values ('claudia',2,gs_keyact);
             insert into USRSIHO.glwkcrys  (cry_nomrep,cry_numsec,cry_chr001 ) values ('claudia',3,gs_keyproT);
             insert into USRSIHO.glwkcrys  (cry_nomrep,cry_numsec,cry_chr001 ) values ('claudia',4,wi_numplz);
            DELETE FROM USRSIHO.holoplza WHERE plz_keydep =gs_keyproT AND plz_keypue = gs_keyact AND plz_ctvplz = wi_numplz AND plz_asig =ws_valaux;
         END IF;
      END IF;
END IF;
IF i_accion = 3 THEN -- Autoriza de 0 -> 1 ?? 1 -> 0
    BEGIN
       SELECT arg_keycam
       INTO gs_keypro
       FROM USRSIHO.glcoargu
       WHERE arg_idepro = s_idepro
       AND arg_idepcc = s_idepcc
       AND arg_keyusu = i_keyusu
       AND arg_pvalor = 'MODI'
       AND arg_descam = 'gs_keypro';
       EXCEPTION WHEN no_data_found THEN gs_keypro := '';
    END;
    BEGIN
       SELECT arg_keycam
       into gs_keyact
       FROM USRSIHO.glcoargu
       WHERE arg_idepro = s_idepro
       AND arg_idepcc = s_idepcc
       AND arg_keyusu = i_keyusu
       AND arg_pvalor = 'MODI'
       AND arg_descam = 'gs_keyact';
       EXCEPTION WHEN no_data_found THEN gs_keyact := '';
    END;
    BEGIN
       SELECT arg_keycam
       into gn_presup
       FROM USRSIHO.glcoargu
       WHERE arg_idepro = s_idepro
       AND arg_idepcc = s_idepcc
       AND arg_keyusu = i_keyusu
       AND arg_pvalor = 'MODI'
       AND arg_descam = 'gn_presup';
       EXCEPTION WHEN no_data_found THEN gn_presup := 0;
    END;
    BEGIN
       SELECT arg_keycam
       into ws_valaux
       FROM USRSIHO.glcoargu
       WHERE arg_idepro = s_idepro
       AND arg_idepcc = s_idepcc
       AND arg_keyusu = i_keyusu
       AND arg_pvalor = 'MODI'
       AND arg_descam = 'ws_valaux';
       EXCEPTION WHEN no_data_found THEN ws_valaux := '';
    END;
    BEGIN
       SELECT arg_keycam
       into wn_valsta
       FROM USRSIHO.glcoargu
       WHERE arg_idepro = s_idepro
       AND arg_idepcc = s_idepcc
       AND arg_keyusu = i_keyusu
       AND arg_pvalor = 'MODI'
       AND arg_descam = 'wn_valsta';
       EXCEPTION WHEN no_data_found THEN wn_valsta := 0;
    END;
    BEGIN
       SELECT arg_keycam
       into wi_numplz
       FROM USRSIHO.glcoargu
       WHERE arg_idepro = s_idepro
       AND arg_idepcc = s_idepcc
       AND arg_keyusu = i_keyusu
       AND arg_pvalor = 'MODI'
       AND arg_descam = 'wi_numplz';
       EXCEPTION WHEN no_data_found THEN wi_numplz := 0;
    END;
---PASA DE PENDIENTE A AUTORIZADA  (0--->1)
      IF wn_valsta = 0 Then
         UPDATE USRSIHO.holoplza SET plz_status = 1, plz_keyusg = i_keyusu
         WHERE plz_ctvplz = wi_numplz and plz_asig = ws_valaux;
      END IF;
---PASA DE AUTORIZADA A PENDIENTE  (1--->0)
      IF wn_valsta = 1 Then
          UPDATE USRSIHO.holoplza SET plz_status = 0, plz_keyusg = i_keyusu
          WHERE plz_ctvplz = wi_numplz and plz_asig = ws_valaux;
      End IF;
      wn_ult_plz := wi_numplz;
--RETURN wn_ult_plz;
END IF;
numplaza := wn_ult_plz;
end;
/
