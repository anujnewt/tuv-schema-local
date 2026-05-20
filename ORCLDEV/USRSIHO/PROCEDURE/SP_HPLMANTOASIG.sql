CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_HPLMANTOASIG" (s_idepro VARCHAR2, s_idepcc VARCHAR2,
                             i_keyusu number, i_accion NUMBER) IS
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
   wi_primer NUMBER(10) ;
   wn_i NUMBER(10);
   gn_totcap  NUMBER(10);
   lnKeyFol   NUMBER(10);
   i_totcap   NUMBER(10) ;
   wn_valsta  NUMBER(10);
   gs_keyact  VARCHAR2 (16);
   gs_key_act VARCHAR2 (16);
   gs_mtomax number(10);
   gn_cos_tot NUMBER(10);
   wn_num_plz NUMBER(10);
   gs_keypro  VARCHAR2 (16);
   gs_keyproT VARCHAR2 (16);
   gs_key_pro VARCHAR2 (16);
   wn_valida  NUMBER(10);
   tx_fec_ini VARCHAR2 (10);
   tx_fec_ven VARCHAR2 (10);
   ws_plazaprimaria VARCHAR2 (02);
   i_movpla20 NUMBER(10);
   i_movpla18 NUMBER(10);
   gn_presup  NUMBER(10);
   ws_valaux  VARCHAR2 (16);
   i_busca    NUMBER(10);
   w_status   NUMBER(10);
   wn_keyemp  NUMBER(10);
   ws_excepcion VARCHAR2 (02);
   li_err_num NUMBER(10);
BEGIN
   -- ---------------------------------------------------------------------------------------------------------
   -- Limpia variables de trabajo
   IF i_accion = 1 THEN -- Inserta
        BEGIN
            SELECT arg_keycam
              INTO gs_key_act
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
            into gs_mtomax
            FROM USRSIHO.glcoargu
            WHERE arg_idepro = s_idepro
             AND arg_idepcc = s_idepcc
             AND arg_keyusu = i_keyusu
             AND arg_pvalor = 'ALTA'
             AND arg_descam = 'gs_des_act';
             EXCEPTION WHEN no_data_found THEN gs_mtomax := '';
        END;
--      SELECT arg_keycam
--        into gn_cos_tot
--        FROM USRSIHO.glcoargu
--       WHERE arg_idepro = s_idepro
--         AND arg_idepcc = s_idepcc
--         AND arg_keyusu = i_keyusu
--         AND arg_pvalor = 'ALTA'
--         AND arg_descam = 'gn_cos_tot';
        BEGIN
            SELECT arg_keycam
              INTO ws_plazaprimaria
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
            into wn_num_plz
            FROM USRSIHO.glcoargu
            WHERE arg_idepro = s_idepro
             AND arg_idepcc = s_idepcc
             AND arg_keyusu = i_keyusu
             AND arg_pvalor = 'ALTA'
             AND arg_descam = 'wn_num_plz';
             EXCEPTION WHEN no_data_found THEN ws_plazaprimaria := 0;
        END;
--      SELECT arg_keycam
--        into wn_valida
--        FROM USRSIHO.glcoargu
--       WHERE arg_idepro = s_idepro
--         AND arg_idepcc = s_idepcc
--         AND arg_keyusu = i_keyusu
--         AND arg_pvalor = 'ALTA'
--         AND arg_descam = 'wn_valida';
--      SELECT arg_keycam
--        into tx_fec_ini
--        FROM USRSIHO.glcoargu
--       WHERE arg_idepro = s_idepro
--         AND arg_idepcc = s_idepcc
--         AND arg_keyusu = i_keyusu
--         AND arg_pvalor = 'ALTA'
--         AND arg_descam = 'tx_fec_ini';
--     SELECT arg_keycam
--       into tx_fec_ven
--       FROM USRSIHO.glcoargu
--      WHERE arg_idepro = s_idepro
--        AND arg_idepcc = s_idepcc
--        AND arg_keyusu = i_keyusu
--        AND arg_pvalor = 'ALTA'
--        AND arg_descam = 'tx_fec_ven';
        BEGIN
            SELECT arg_keycam
              INTO gs_key_pro
              FROM USRSIHO.glcoargu
             WHERE arg_idepro = s_idepro
               AND arg_idepcc = s_idepcc
               AND arg_keyusu = i_keyusu
               AND arg_pvalor = 'ALTA'
               AND arg_descam = 'gs_key_pro';
            EXCEPTION WHEN no_data_found THEN gs_key_pro := '';
        END;
-- no inserta valor para wn_valida el programa
--     IF wn_valida = 1 THEN
--        SELECT arg_keycam, arg_descam
--          into wi_primer, wn_j
--          FROM USRSIHO.glcoargu
--         WHERE arg_idepro = s_idepro
--           AND arg_idepcc = s_idepcc
--           AND arg_keyusu = i_keyusu
--           AND arg_pvalor = 'ARREGLO';
--     ELSE
        wi_primer := 0;
        wn_j := 0;
--     END IF;
--     SELECT arg_keycam
--       into gn_totcap
--       FROM USRSIHO.glcoargu
--      WHERE arg_idepro = s_idepro
--        AND arg_idepcc = s_idepcc
--        AND arg_keyusu = i_keyusu
--        AND arg_pvalor = 'ALTA'
--        AND arg_descam = 'gn_totcap';
        BEGIN
            SELECT arg_keycam
              INTO wn_keyemp
              FROM USRSIHO.glcoargu
             WHERE arg_idepro = s_idepro
               AND arg_idepcc = s_idepcc
               AND arg_keyusu = i_keyusu
               AND arg_pvalor = 'ALTA'
               AND arg_descam = 'wn_keyemp';
            EXCEPTION WHEN no_data_found THEN wn_keyemp := 0;
        END;
        BEGIN
            SELECT arg_keycam
              INTO ws_excepcion
              FROM USRSIHO.glcoargu
             WHERE arg_idepro = s_idepro
               AND arg_idepcc = s_idepcc
               AND arg_keyusu = i_keyusu
               AND arg_pvalor = 'ALTA'
               AND arg_descam = 'ws_excepcion';
            EXCEPTION WHEN no_data_found THEN ws_excepcion := '';
        END;
        --Contorl de errores
       -- SET LOCK MODE TO WAIT;
  	  --   LOCK TABLE holoplza IN EXCLUSIVE MODE;
        BEGIN
            SELECT MAX(plz_asig)
              INTO lnKeyFol
              FROM holoplza
             WHERE plz_ctvplz = wn_num_plz;
            EXCEPTION WHEN no_data_found THEN lnKeyFol := 0;
        END;
	     -- Si es el primero se asigna uno
	     IF lnKeyFol IS NULL THEN
	        lnKeyFol := 1;
	     ELSE
	        lnKeyFol := lnKeyFol + 1;
	     END IF;
         ---Inserta la Plaza, indicando el Usuario que la genera
        INSERT INTO holoplza (plz_ctvplz,plz_keyfol, plz_keytco, plz_keydep,
                              plz_keypue, plz_keyemp, plz_numcap, plz_capini,
                              plz_capfin, plz_keytab, plz_cosuni, plz_keytva,
                              plz_status, plz_fecini, plz_fecalt, plz_keyusg,
                              plz_hrsmod, plz_mtomax,plz_mtoeje,plz_primaria,
                              plz_fecven,plz_asig,plz_excep)
                      VALUES (wn_num_plz,null, null, gs_key_pro,
                              gs_key_act, wn_keyemp, null, wi_primer,
                              wn_j, null, 0, 0,
                              0, null, trunc(sysdate), i_keyusu,
                              null,gs_mtomax,null,ws_plazaprimaria,
                              null,lnKeyFol,ws_excepcion);
  	    -- UNLOCK TABLE holoplza;
  	  -- END;
   END IF;
END;
/
