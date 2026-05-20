CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_HNMREPLN" (vs_nom_rep IN VARCHAR2,
                                        vs_ide_pcc IN VARCHAR2,
                                        vn_key_usu IN NUMBER,
                                        vn_prokey IN NUMBER) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
  -- SIPROS, S. A. DE C. V.
  --
  -- Sistema  : RH-2000  C/S
  -- Modulo   : Administracion de Remuneraciones (nm)
  -- Programa : sp_hnmrepln
  --            Listado de pagos por proceso
  -- Autor    : Veronica Vazquez Rodriguez
  -- Fecha    : 19 de Agosto de 1999
  vn_key_nom   usrsiho.nmloperi.per_keynom %TYPE;
  vs_key_per   usrsiho.nmloperi.per_keyper %TYPE;
  vs_num_emi   usrsiho.nmloperi.per_nu4aux %TYPE;
  vn_key_emp   usrsiho.nmcoempl.emp_keyemp %TYPE;
  vn_emp_ant   usrsiho.nmcoempl.emp_keyemp %TYPE;
  vs_nom_emp   usrsiho.nmcoempl.emp_nomemp %TYPE;
  vs_reg_rfc   usrsiho.nmcoempl.emp_regrfc %TYPE;
  vs_key_con   usrsiho.nmwkmovt.mov_keycon %TYPE;
  vs_des_con   usrsiho.nmloconc.con_descon %TYPE;
  vs_cod_imp   usrsiho.nmwkmovt.mov_codimp %TYPE;
  vn_imp_ort   usrsiho.nmwkmovt.mov_import %TYPE;
  vn_row_ide   usrsiho.nmwkmovt.mov_rowide %TYPE;  -- Variable para columna que se agrega en el select principal
  vn_key_pro   usrsiho.nmwkmovt.mov_keypro %TYPE;
  vn_key_agr   usrsiho.holoagcp.agc_keyagr %TYPE;
  vs_vec_001   CHAR(20);
  vn_con_001   NUMBER(5);
  vn_con_002   NUMBER(5);
  vn_con_per   NUMBER(5);
  vn_con_ded   NUMBER(5);
  vn_con_pro   NUMBER(5);
  vd_fec_ini   DATE;
  vd_fec_fin   DATE;
  vd_fec_pag   DATE;
  vs_nom_seg varchar(10);
BEGIN
  vn_emp_ant := 0;
  vs_nom_seg := rtrim(substr(vs_ide_pcc,1,10));
  -- Se agrega la columna nmwkmovt.mov_rowide, ya que no agrupara el importe de
  -- descuentos de Sitatyr y se agrega en el gruop by el campo
  -- Marzo 2010 - CAR
      FOR rec
         IN (SELECT nmloperi.per_keypro, nmloperi.per_keynom,
                nmloperi.per_keyper, nmloperi.per_nu4aux,
                nmloperi.per_fecini, nmloperi.per_fecfin,
                nmloperi.per_fecpag,
                nmcoempl.emp_keyemp, nmcoempl.emp_nomemp,
                nmcoempl.emp_regrfc, nmwkmovt.mov_keycon,
                nmloconc.con_descon, nmwkmovt.mov_codimp,
                nmwkmovt.mov_rowide,
                sum(nmwkmovt.mov_import) suma
             FROM usrsiho.nmcoempl,
                usrsiho.nmwkmovt,
                usrsiho.nmloperi,
                usrsiho.nmloconc
          WHERE per_keypro = mov_keypro
            AND per_keyper = mov_keyper
            AND mov_keyemp = emp_keyemp
            AND mov_keycon = con_keycon
            AND mov_keypro = vn_prokey
            AND per_keyper IN(SELECT ran_keyper
                                FROM usrsiho.glwkrang
                               WHERE ran_nomrep = vs_nom_rep
                                 AND ran_idepcc = vs_ide_pcc
                                 AND ran_keyusu = vn_key_usu)
            AND mov_codimp IN('01','02','03')
         GROUP BY nmloperi.per_keypro, nmloperi.per_keynom,
                  nmloperi.per_keyper, nmloperi.per_nu4aux,
                  nmloperi.per_fecini, nmloperi.per_fecfin,
                  nmloperi.per_fecpag,
                  nmcoempl.emp_keyemp, nmcoempl.emp_nomemp,
                  nmcoempl.emp_regrfc, nmwkmovt.mov_codimp,
                  nmwkmovt.mov_keycon, nmloconc.con_descon,
                  nmwkmovt.mov_rowide
        ORDER BY per_keyper,emp_keyemp) LOOP
        vn_key_pro := rec.per_keypro;
        vn_key_nom := rec.per_keynom;
        vs_key_per := rec.per_keyper;
        vs_num_emi := rec.per_nu4aux;
        vd_fec_ini := rec.per_fecini;
        vd_fec_fin := rec.per_fecfin;
        vd_fec_pag := rec.per_fecpag;
        vn_key_emp := rec.emp_keyemp;
        vs_nom_emp := rec.emp_nomemp;
        vs_reg_rfc := rec.emp_regrfc;
        vs_key_con := rec.mov_keycon;
        vs_des_con := rec.con_descon;
        vs_cod_imp := rec.mov_codimp;
        vn_row_ide := rec.mov_rowide;
        vn_imp_ort := rec.suma;
        IF vn_emp_ant <> vn_key_emp THEN
           vn_con_per := 0;
           vn_con_ded := 0;
           vn_con_pro := 0;
        END IF;
        vn_con_001 := 0;
        vs_vec_001 := '..................';
        FOR rec2
           IN (SELECT agc_keyagr
             FROM holoagcp
            WHERE agc_keycon = vs_key_con) LOOP
           vn_con_001 := rec2.agc_keyagr;
           IF vn_con_001 = 1 THEN
              vs_vec_001 := 'X' || SUBSTR(vs_vec_001,2, 19);
           END IF;
           IF vn_con_001 = 2 THEN
              vs_vec_001 := SUBSTR( vs_vec_001,1, 1)|| 'X' || substr(vs_vec_001,3,18);
           END IF;
           IF vn_con_001 = 3 THEN
              --SUBSTR(vs_vec_001,3, 1) := 'X';
              vs_vec_001 := SUBSTR( vs_vec_001,1, 2) || 'X' || substr(vs_vec_001,4,17);
           END IF;
           IF vn_con_001 = 4 THEN
              --SUBSTR(vs_vec_001,4, 1) := 'X';
              vs_vec_001 := SUBSTR( vs_vec_001,1, 3) || 'X' || substr(vs_vec_001,5,16);
           END IF;
           IF vn_con_001 = 5 THEN
              --SUBSTR(vs_vec_001,5, 1) := 'X';
              vs_vec_001 := SUBSTR( vs_vec_001,1, 4) || 'X' || substr(vs_vec_001,6,15);
           END IF;
           IF vn_con_001 = 6 THEN
              --SUBSTR(vs_vec_001,6, 1) := 'X';
              vs_vec_001 := SUBSTR( vs_vec_001,1, 5) || 'X' || substr(vs_vec_001,7,14);
           END IF;
           IF vn_con_001 = 7 THEN
              --SUBSTR(vs_vec_001,7, 1) := 'X';
              vs_vec_001 := SUBSTR( vs_vec_001,1, 6) || 'X' || substr(vs_vec_001,8,13);
           END IF;
           IF vn_con_001 = 8 THEN
              --SUBSTR(vs_vec_001,8, 1) := 'X';
              vs_vec_001 := SUBSTR( vs_vec_001,1, 7) || 'X' || substr(vs_vec_001,9,12);
           END IF;
           IF vn_con_001 = 9 THEN
              --SUBSTR(vs_vec_001,9, 1) := 'X';
              vs_vec_001 := SUBSTR( vs_vec_001,1, 8) || 'X' || substr(vs_vec_001,10,11);
           END IF;
           IF vn_con_001 = 10 THEN
              --SUBSTR( vs_vec_001,10, 1) := 'X';
              vs_vec_001 := SUBSTR( vs_vec_001,1, 9) || 'X' || substr(vs_vec_001,11,10);
           END IF;
        END LOOP;
        vn_emp_ant := vn_key_emp;
        IF vs_cod_imp = '01' THEN
           vn_con_per := vn_con_per + 1;
           UPDATE usrsiho.glwkcrys
              SET
                   cry_chr017 = vs_key_con,
                                  cry_chr002 = vs_des_con,
                                  cry_chr008 = vs_vec_001,
                                  cry_dec001 = vn_imp_ort
             WHERE cry_nomrep = vs_nom_rep
               AND cry_idepcc = vs_ide_pcc
               AND cry_keyusu = vn_key_usu
               AND cry_dec006 = vn_key_emp
               AND cry_numsec = vn_con_per;
           IF sql%rowcount  = 0 THEN
              INSERT INTO usrsiho.glwkcrys(cry_nomrep, cry_idepcc, cry_keyusu,
                                   cry_numsec, cry_dec006, cry_chr012,
                                   cry_chr001, cry_dec008, cry_dec009,
                                   cry_dec010, cry_chr017, cry_chr002,
                                   cry_chr008, cry_dec001, cry_chr020,
                                   cry_dat001, cry_dat002, cry_dat003,cry_chr016)
                            VALUES(vs_nom_rep, vs_ide_pcc, vn_key_usu,
                                   vn_con_per, vn_key_emp, vs_reg_rfc,
                                   vs_nom_emp, vn_key_pro, vn_key_nom,
                                   vs_num_emi, vs_key_con, vs_des_con,
                                   vs_vec_001, vn_imp_ort, vs_key_per,
                                   vd_fec_ini, vd_fec_fin, vd_fec_pag,vs_nom_seg);
           END IF;
        ELSIF vs_cod_imp = '02' THEN
           vn_con_ded := vn_con_ded + 1;
           UPDATE usrsiho.glwkcrys
              SET
                   cry_chr018 = vs_key_con,
                                  cry_chr003 = vs_des_con,
                                  cry_chr009 = vs_vec_001,
                                  cry_dec002 = vn_imp_ort
             WHERE cry_nomrep = vs_nom_rep
               AND cry_idepcc = vs_ide_pcc
               AND cry_keyusu = vn_key_usu
               AND cry_dec006 = vn_key_emp
               AND cry_numsec = vn_con_ded;
           IF sql%rowcount = 0 THEN
              INSERT INTO usrsiho.glwkcrys(cry_nomrep, cry_idepcc, cry_keyusu,
                                   cry_numsec, cry_dec006, cry_chr012,
                                   cry_chr001, cry_dec008, cry_dec009,
                                   cry_dec010, cry_chr018, cry_chr003,
                                   cry_chr009, cry_dec002, cry_chr020,
                                   cry_dat001, cry_dat002, cry_dat003,cry_chr016)
                            VALUES(vs_nom_rep, vs_ide_pcc, vn_key_usu,
                                   vn_con_ded, vn_key_emp, vs_reg_rfc,
                                   vs_nom_emp, vn_key_pro, vn_key_nom,
                                   vs_num_emi, vs_key_con, vs_des_con,
                                   vs_vec_001, vn_imp_ort, vs_key_per,
                                   vd_fec_ini, vd_fec_fin, vd_fec_pag,vs_nom_seg);
           END IF;
        ELSE
           vn_key_agr := 0;
           begin
             SELECT agc_keyagr
               INTO vn_key_agr
               FROM usrsiho.holoagcp
              WHERE agc_keyagr = 9
                AND agc_keycon = vs_key_con;
              exception
             when no_data_found THEN CONTINUE;
          end;
          -- END IF;
           vn_con_pro := vn_con_pro + 1;
           UPDATE usrsiho.glwkcrys
              SET
                   cry_chr019 = vs_key_con,
                                  cry_chr004 = vs_des_con,
                                  cry_chr010 = vs_vec_001,
                                  cry_dec003 = vn_imp_ort
             WHERE cry_nomrep = vs_nom_rep
               AND cry_idepcc = vs_ide_pcc
               AND cry_keyusu = vn_key_usu
               AND cry_dec006 = vn_key_emp
               AND cry_numsec = vn_con_pro;
           IF sql%rowcount = 0 THEN
              INSERT INTO usrsiho.glwkcrys(cry_nomrep, cry_idepcc, cry_keyusu,
                                   cry_numsec, cry_dec006, cry_chr012,
                                   cry_chr001, cry_dec008, cry_dec009,
                                   cry_dec010, cry_chr019, cry_chr004,
                                   cry_chr010, cry_dec003, cry_chr020,
                                   cry_dat001, cry_dat002, cry_dat003, cry_chr016)
                            VALUES(vs_nom_rep, vs_ide_pcc, vn_key_usu,
                                   vn_con_pro, vn_key_emp, vs_reg_rfc,
                                   vs_nom_emp, vn_key_pro, vn_key_nom,
                                   vs_num_emi, vs_key_con, vs_des_con,
                                   vs_vec_001, vn_imp_ort, vs_key_per,
                                   vd_fec_ini, vd_fec_fin, vd_fec_pag,vs_nom_seg);
           END IF;
        END IF;
     END LOOP;
END;
/
