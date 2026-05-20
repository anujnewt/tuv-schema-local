CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_HNMREPLA1" (vs_nom_rep in varchar2, vs_ide_pcc in VARCHAR2, vn_key_usu IN NUMBER) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
  vn_key_nom   usrsiho.nmloperi.per_keynom %TYPE;
  vs_num_emi   usrsiho.nmloperi.per_nu4aux %TYPE;
  vn_key_pro   usrsiho.nmloperi.per_keypro %TYPE;
  vs_key_per   usrsiho.nmloperi.per_keyper %TYPE;
  vn_key_emp   usrsiho.nmcoempl.emp_keyemp %TYPE;
  vn_emp_ant   usrsiho.nmcoempl.emp_keyemp %TYPE;
  vs_nom_emp   usrsiho.nmcoempl.emp_nomemp %TYPE;
  vs_reg_rfc   usrsiho.nmcoempl.emp_regrfc %TYPE;
  vs_key_con   usrsiho.nmlohism.his_keycon %TYPE;
  vs_des_con   usrsiho.nmloconc.con_descon %TYPE;
  vs_cod_imp   usrsiho.nmlohism.his_codimp %TYPE;
  vn_imp_ort   usrsiho.nmlohism.his_import %TYPE;
  vs_key_dep   usrsiho.nmcodeps.dep_keydep %TYPE;
  vs_des_dep   usrsiho.nmcodeps.dep_desdep %TYPE;
  vn_key_agr   usrsiho.holoagcp.agc_keyagr %TYPE;
  vn_key_rph   usrsiho.holofrph.frp_keyrph %TYPE;
  vd_fec_act   usrsiho.holofrph.frp_fecact %TYPE;
  vn_cos_tot   usrsiho.holohgdp.hgd_costog %TYPE;
  vn_cos_tog   usrsiho.holohgdp.hgd_costog %TYPE;
  vn_cap_ini   usrsiho.holohgdp.hgd_capini %TYPE;
  vn_cap_fin   usrsiho.holohgdp.hgd_capfin %TYPE;
  vn_con_per   NUMBER(5);
  vn_con_con   NUMBER(5);
  vn_con_ded   NUMBER(5);
  vn_con_pro   NUMBER(5);
  vd_fec_ini   DATE;
  vd_fec_fin   DATE;
  vd_fec_pag   DATE;
  cuenta     number(5);
  vs_nom_seg varchar(10);
BEGIN
  vn_emp_ant := 0;
  vs_nom_seg := rtrim(substr(vs_ide_pcc,1,10));
-- INICIA CICLO PRINCIPAL DE LECTURA
      FOR rec
         IN (SELECT nmloperi.per_keypro, nmloperi.per_keynom, nmloperi.per_keyper,nmloperi.per_nu4aux,
                nmloperi.per_fecini, nmloperi.per_fecfin,nmloperi.per_fecpag,nmcoempl.emp_keyemp, nmcoempl.emp_nomemp,
                nmcoempl.emp_regrfc, nmlohism.his_keycon,nmloconc.con_descon, nmlohism.his_codimp,
                nmlohism.his_keydep, nmcodeps.dep_desdep,SUM(nmlohism.his_import) suma
                FROM usrsiho.nmcoempl
                join usrsiho.nmlohism on his_keyemp = emp_keyemp
                join usrsiho.nmloperi on per_keypro = his_keypro AND per_keyper = his_keyper AND per_keynom = his_keynom
                left join usrsiho.nmcodeps on his_keydep = dep_keydep
                join usrsiho.nmloconc on his_keycon = con_keycon
                join usrsiho.glwkrang on ran_nomrep = vs_nom_rep AND ran_idepcc = vs_ide_pcc AND ran_keyusu = vn_key_usu
          WHERE per_keypro = ran_keypro
            AND per_keyper = ran_keyper
            AND per_keynom = ran_keynom
         GROUP BY nmloperi.per_keypro, nmloperi.per_keynom, nmloperi.per_keyper, nmloperi.per_nu4aux,
                  nmloperi.per_fecini, nmloperi.per_fecfin,
                  nmloperi.per_fecpag,
                  nmcoempl.emp_keyemp, nmcoempl.emp_nomemp,
                  nmcoempl.emp_regrfc, nmlohism.his_codimp,
                  nmlohism.his_keycon, nmloconc.con_descon,
                  nmlohism.his_keydep, nmcodeps.dep_desdep
         ORDER BY emp_keyemp) LOOP
-- COMPARACION DE NUMEROS DE EMPLEADO
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
        vs_key_con := rec.his_keycon;
        vs_des_con := rec.con_descon;
        vs_cod_imp := rec.his_codimp;
        vs_key_dep := rec.his_keydep;
        vs_des_dep := rec.dep_desdep;
        vn_imp_ort := rec.suma;
  --dbms_output.put_line( vn_key_emp);
        IF vn_emp_ant <> vn_key_emp THEN
           vn_con_per := 0;
           vn_con_ded := 0;
           vn_con_pro := 0;
        END IF;
        vn_emp_ant := vn_key_emp;
-- SEPARA POR TIPO DE CONCEPTO
        IF (vs_cod_imp = '01') THEN
-- VERIFICA SI PERTENECEN A LA AGRUPACION 10
           vn_con_con := 0;
           BEGIN
               SELECT COUNT(*)
                 INTO vn_con_con
                 FROM usrsiho.holoagcp
                WHERE agc_keyagr = 10
                  AND agc_keycon = vs_key_con;
                EXCEPTION WHEN no_data_found THEN vn_con_con := 0;
            END;
     --dbms_output.put_line( vs_key_con);
     --dbms_output.put_line(vn_con_con);
-- SELECCIONA DETALLE DE MOVIMIENTO
           IF vn_con_con > 0 THEN
              FOR rec2
                 IN (SELECT frp_keyrph, frp_fecact,
                        hgd_costog, hgd_capini,
                        hgd_capfin, (hgd_numcap*hgd_costog) cos_tot
                                     FROM usrsiho.holofrph, usrsiho.holohgdp
                                      WHERE frp_keyrph = hgd_keyrph
                                        AND frp_keypro = vn_key_pro
                                        AND frp_keyper = vs_key_per
                                        AND hgd_keyemp = vn_key_emp) LOOP
     --dbms_output.put_line( 'segundo for');
                 vn_key_rph := rec2.frp_keyrph;
                 vd_fec_act := rec2.frp_fecact;
                 vn_cos_tog := rec2.hgd_costog;
                 vn_cap_ini := rec2.hgd_capini;
                 vn_cap_fin := rec2.hgd_capfin;
                 vn_cos_tot := rec2.cos_tot;
                 vn_con_per := vn_con_per + 1;
                 UPDATE usrsiho.glwkcrys
                    SET  cry_dec008 = vn_key_pro, cry_dec009 = vn_key_nom, cry_dec010 = vs_num_emi,
                         cry_chr017 = vs_key_con, cry_chr002 = vs_des_con, cry_chr008 = vs_key_dep,
                         cry_chr009 = vs_des_dep, cry_dec007 = vn_key_rph, cry_dat001 = vd_fec_act,
                         cry_dec005 = vn_cos_tog, cry_dec011 = vn_cap_ini, cry_dec012 = vn_cap_fin,
                         cry_dec004 = vn_cos_tot, cry_dec001 = vn_imp_ort
                   WHERE cry_nomrep = vs_nom_rep
                     AND cry_idepcc = vs_ide_pcc
                     AND cry_keyusu = vn_key_usu
                     AND cry_dec006 = vn_key_emp
                     AND cry_numsec = vn_con_per;
                 IF sql%rowcount  = 0 THEN
                 --dbms_output.put_line (vn_key_pro);
                    INSERT INTO usrsiho.glwkcrys(cry_nomrep, cry_idepcc, cry_keyusu,
                                         cry_numsec, cry_dec006, cry_chr012,
                                         cry_chr001, cry_dec008, cry_dec009,
                                         cry_dec010, cry_chr017, cry_chr002,
                                         cry_chr008, cry_chr009, cry_dec007,
                                         cry_dat001, cry_dec005, cry_dec011,
                                         cry_dec012, cry_dec004, cry_dec001,
                                         cry_chr020, cry_dat002, cry_dat003,
                                         cry_dat004, cry_chr016)
                                  VALUES(vs_nom_rep, vs_ide_pcc, vn_key_usu,
                                         vn_con_per, vn_key_emp, vs_reg_rfc,
                                         vs_nom_emp, vn_key_pro, vn_key_nom,
                                         vs_num_emi, vs_key_con, vs_des_con,
                                         vs_key_dep, vs_des_dep, vn_key_rph,
                                         vd_fec_act, vn_cos_tog, vn_cap_ini,
                                         vn_cap_fin, vn_cos_tot, vn_imp_ort,
                                         vs_key_per, vd_fec_ini, vd_fec_fin,
                                         vd_fec_pag, vs_nom_seg);
                 END IF;
              END LOOP;
           ELSE
              vn_con_per := vn_con_per + 1;
              UPDATE usrsiho.glwkcrys
                 SET cry_chr017 = vs_key_con, cry_chr002 = vs_des_con, cry_chr008 = vs_key_dep,
                      cry_chr009 = vs_des_dep, cry_dec001 = vn_imp_ort
                WHERE cry_nomrep = vs_nom_rep
                  AND cry_idepcc = vs_ide_pcc
                  AND cry_keyusu = vn_key_usu
                  AND cry_dec006 = vn_key_emp
                  AND cry_numsec = vn_con_per;
                  cuenta := sql%rowcount;
       -- dbms_output.put_line(cuenta);
              IF cuenta  = 0 THEN
               -- dbms_output.put_line('inserta registro');
                 INSERT INTO usrsiho.glwkcrys(cry_nomrep, cry_idepcc, cry_keyusu,
                                      cry_numsec, cry_dec006, cry_chr012,
                                      cry_chr001, cry_dec008, cry_dec009,
                                      cry_dec010, cry_chr017, cry_chr002,
                                      cry_chr008, cry_chr009, cry_dec001,
                                      cry_chr020, cry_dat002, cry_dat003,
                                      cry_dat004, cry_chr016)
                                VALUES(vs_nom_rep, vs_ide_pcc, vn_key_usu,
                                       vn_con_per, vn_key_emp, vs_reg_rfc,
                                       vs_nom_emp, vn_key_pro, vn_key_nom,
                                       vs_num_emi, vs_key_con, vs_des_con,
                                       vs_key_dep, SUBSTR(vs_des_dep,1,20), vn_imp_ort,
                                       vs_key_per, vd_fec_ini, vd_fec_fin,
                                       vd_fec_pag, vs_nom_seg);
              END IF;
           END IF;
        ELSIF vs_cod_imp = '02' THEN
           vn_con_ded := vn_con_ded + 1;
           UPDATE usrsiho.glwkcrys
              SET cry_chr018 = vs_key_con, cry_chr003 = vs_des_con, cry_dec002 = vn_imp_ort
             WHERE cry_nomrep = vs_nom_rep
               AND cry_idepcc = vs_ide_pcc
               AND cry_keyusu = vn_key_usu
               AND cry_dec006 = vn_key_emp
               AND cry_numsec = vn_con_ded;
           IF sql%rowcount = 0 THEN
         --  dbms_output.put_line('inserta registro');
              INSERT INTO usrsiho.glwkcrys(cry_nomrep, cry_idepcc, cry_keyusu,
                                   cry_numsec, cry_dec006, cry_chr012,
                                   cry_chr001, cry_dec008, cry_dec009,
                                   cry_dec010, cry_chr018, cry_chr003,
                                   cry_dec002, cry_chr020, cry_dat002,
                                   cry_dat003, cry_dat004, cry_chr016)
                             VALUES(vs_nom_rep, vs_ide_pcc, vn_key_usu,
                                    vn_con_ded, vn_key_emp, vs_reg_rfc,
                                    vs_nom_emp, vn_key_pro, vn_key_nom,
                                    vs_num_emi, vs_key_con, vs_des_con,
                                    vn_imp_ort, vs_key_per, vd_fec_ini,
                                    vd_fec_fin, vd_fec_pag, vs_nom_seg);
           END IF;
        ELSE
           --vn_key_agr := 0;
           --SELECT agc_keyagr INTO vn_key_agr
           --  FROM usrsiho.holoagcp
           -- WHERE agc_keyagr = 9
           --   AND agc_keycon = vs_key_con;
           --IF sql%rowcount = 0 THEN
           --   CONTINUE;
           --END IF;
           vn_key_agr := 0;
           SELECT count(*)
             INTO vn_key_agr
             FROM USRSIHO.HOLOAGCP
            WHERE agc_keyagr = 9
              AND agc_keycon = vs_key_con;
           IF vn_key_agr > 0 THEN
             vn_con_pro := vn_con_pro + 1;
             UPDATE usrsiho.glwkcrys
                SET  cry_chr019 = vs_key_con, cry_chr004 = vs_des_con, cry_dec003 = vn_imp_ort
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
                                     cry_dec003, cry_chr020, cry_dat002,
                                     cry_dat003, cry_dat004, cry_chr016)
                              VALUES(vs_nom_rep, vs_ide_pcc, vn_key_usu,
                                     vn_con_pro, vn_key_emp, vs_reg_rfc,
                                     vs_nom_emp, vn_key_pro, vn_key_nom,
                                     vs_num_emi, vs_key_con, vs_des_con,
                                     vn_imp_ort, vs_key_per, vd_fec_ini,
                                     vd_fec_fin, vd_fec_pag, vs_nom_seg);
             END IF;
           END IF;
        END IF;
     END LOOP;
END;
/
