CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_HPLREPPL" (pi_usuario  NUMBER,
                                         ps_terminal VARCHAR2,
                                         contipcon   VARCHAR2) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
   li_keyfol      NUMBER(10);
   li_keypue      NUMBER(10);
   li_keyemp      NUMBER(10);
   li_keytva      NUMBER(10);
   li_numcap      NUMBER(10);
   li_numcdi      NUMBER(10);
   li_ctvplz      NUMBER(10);
   li_keyplz      NUMBER(10);
   ls_keydep      VARCHAR2(16);
   ls_keypue      VARCHAR2(16);
   ls_keycia      VARCHAR2(16);
   ls_keyapr      VARCHAR2(16);
   ls_desdep      VARCHAR2(40);
   ls_despue      VARCHAR2(40);
   ls_descia      VARCHAR2(40);
   ls_desapr      VARCHAR2(40);
   ls_capitulos   VARCHAR2(100);
   ls_nomemp      VARCHAR2(60);
   ln_costot      NUMBER(16,2);
   ln_cosuni      NUMBER(16,2);
   ld_fechasys    DATE;
BEGIN
-- borra los registros de la tabla de paso.
  DELETE FROM USRSIHO.glwkcrys
  WHERE cry_nomrep = 'HPLREPPL'
    AND cry_keyusu = pi_usuario
    AND cry_idepcc = ps_terminal;
-- lectura de la fecha del systema
   ld_fechasys := TRUNC(SYSDATE);
-- lectura de datos
   IF contipcon = 's' THEN
     FOR rec
        IN (SELECT con_keyplz,con_keyfol,con_keydep, dep_desdep,con_keypue,pue_despue, con_keyemp,emp_nomemp,con_keytva,
               con_numcap,con_numcdi,cia_keycia,   cia_descia,pam_cvesec,pam_nompar,
               con_cosuni,(con_cosuni * con_numcap) costot, con_ctvplz
               FROM USRSIHO.holocont
               left join USRSIHO.nmcoempl on  emp_keyemp = con_keyemp
               join USRSIHO.nmcopues on  pue_keypue = con_keypue
               join USRSIHO.nmcodeps on  dep_keydep = con_keydep
               join USRSIHO.nmloalde on  ald_keydep      = dep_keydep
               join USRSIHO.holodear on  ald_keydep      = dea_keydep
               join USRSIHO.glcoacar on glcoacar.aca_keyapr = dea_keyapr
               join USRSIHO.nmloproc on glcoacar.aca_keypro = pro_keypro
               join USRSIHO.nmlocias on pro_keycia      = cia_keycia
               join USRSIHO.glcoacac on  glcoacac.aca_keyusu = pi_usuario AND glcoacac.aca_keypue = con_keypue
               join USRSIHO.glcopams on dea_keyapr      = pam_cvesec AND pam_keypar      = 'H2'
               join USRSIHO.glwkrang tco on tco.ran_nomrep  = 'HPLREPPL' AND tco.ran_keyusu  = pi_usuario
                    AND tco.ran_idepcc  = ps_terminal AND tco.ran_keypro  = 2 AND tco.ran_keydep  = con_keytco
               join USRSIHO.glwkrang dep on dep.ran_nomrep  = 'HPLREPPL'  AND dep.ran_keyusu  = pi_usuario
                    AND dep.ran_idepcc  = ps_terminal AND dep.ran_keypro  = 1 AND dep.ran_keydep  = con_keydep
               join USRSIHO.glwkrang sts on sts.ran_nomrep  = 'HPLREPPL' AND sts.ran_keyusu  = pi_usuario
                    AND sts.ran_idepcc  = ps_terminal AND sts.ran_keypro  = 3 AND sts.ran_keydep  = con_stspag
               join USRSIHO.glwkrang stp on stp.ran_nomrep  = 'HPLREPPL' AND stp.ran_keyusu  = pi_usuario
                    AND stp.ran_idepcc  = ps_terminal AND stp.ran_keypro  = 4 AND stp.ran_keydep  = con_stsplz
         WHERE  glcoacar.aca_keypro = ald_keypro
           AND glcoacar.aca_keyusu = pi_usuario
           AND glcoacar.aca_actual = 'S'
         ) LOOP
          --   obtiene los capitulos Que estan en el cotrato y los guarda en una
          --   variable llamada ls_capitulos
             li_keyplz := rec.con_keyplz;
             li_keyfol := rec.con_keyfol;
             ls_keydep := rec.con_keydep;
             ls_desdep := rec.dep_desdep;
             ls_keypue := rec.con_keypue;
             ls_despue := rec.pue_despue;
             li_keyemp := rec.con_keyemp;
             ls_nomemp := rec.emp_nomemp;
             li_keytva := rec.con_keytva;
             li_numcap := rec.con_numcap;
             li_numcdi := rec.con_numcdi;
             ls_keycia := rec.cia_keycia;
             ls_descia := rec.cia_descia;
             ls_keyapr := rec.pam_cvesec;
             ls_desapr := rec.pam_nompar;
             ln_cosuni := rec.con_cosuni;
             ln_costot := rec.costot;
             li_ctvplz := rec.con_ctvplz;
             ls_capitulos := ' ';
             IF li_keytva = 1 THEN
                FOR rec2 IN (SELECT coc_keycap
                             FROM USRSIHO.holococa
                             WHERE coc_keyplz = li_keyplz) LOOP
                  li_numcap := rec2.coc_keycap;
                  ls_capitulos := ls_capitulos || TO_CHAR(li_numcap) || ',';
                END LOOP;
             END IF;
              ---- insercion por cada registro obtenido
              INSERT INTO USRSIHO.glwkcrys(cry_nomrep,cry_keyusu,cry_idepcc,cry_numsec,
                                  cry_chr008,cry_chr004,cry_chr009,cry_chr003,
                                  cry_dec006,cry_chr001,cry_chr017,cry_dec007,
                                  cry_dec008,cry_chr018,cry_chr002,cry_chr019,
                                  cry_chr005,cry_chr006,cry_dec001,cry_dec002,
                                  cry_dec009)
                           VALUES('HPLREPPL',pi_usuario,ps_terminal,li_keyfol,
                                   ls_keydep,ls_desdep,ls_keypue,ls_despue,
                                   li_keyemp,ls_nomemp,li_keytva,li_numcap,
                                   li_numcdi,ls_keycia,ls_descia,ls_keyapr,
                                   ls_desapr,ls_capitulos,ln_cosuni,
                                   ln_costot,li_ctvplz);
     END LOOP;
   ELSE
     FOR rec3 IN (SELECT con_keyplz,con_keyfol,con_keydep, dep_desdep,con_keypue,pue_despue,
                    con_keyemp,emp_nomemp,con_keytva, con_numcap,con_numcdi,cia_keycia,
                    cia_descia,pam_cvesec,pam_nompar,con_cosuni,(con_cosuni*con_numcap) costot, con_ctvplz
               FROM USRSIHO.holocont
            left join USRSIHO.nmcoempl on emp_keyemp      = con_keyemp
            join USRSIHO.nmcopues on pue_keypue      = con_keypue
            join USRSIHO.nmcodeps on dep_keydep      = con_keydep
            join USRSIHO.nmloalde on ald_keydep      = dep_keydep
            join USRSIHO.holodear on ald_keydep      = dea_keydep
            join USRSIHO.glcoacar on glcoacar.aca_keypro = ald_keypro
            join USRSIHO.nmloproc on glcoacar.aca_keypro = pro_keypro
            join USRSIHO.nmlocias on pro_keycia      = cia_keycia
            join USRSIHO.glcoacac on glcoacac.aca_keyusu = pi_usuario AND glcoacac.aca_keypue = con_keypue
            join USRSIHO.glcopams on dea_keyapr      = pam_cvesec AND pam_keypar      = 'H2'
            left join USRSIHO.glwkrang tco on tco.ran_nomrep  = 'HPLREPPL' AND tco.ran_keyusu  = pi_usuario
                AND tco.ran_idepcc  = ps_terminal AND tco.ran_keypro  = 2  AND tco.ran_keydep  = con_keytco
            join USRSIHO.glwkrang dep on dep.ran_nomrep  = 'HPLREPPL' AND dep.ran_keyusu  = pi_usuario
                AND dep.ran_idepcc  = ps_terminal AND dep.ran_keypro  = 1 AND dep.ran_keydep  = con_keydep
            join USRSIHO.glwkrang sts on  sts.ran_nomrep  = 'HPLREPPL' AND sts.ran_keyusu  = pi_usuario
                AND sts.ran_idepcc  = ps_terminal AND sts.ran_keypro  = 3 AND sts.ran_keydep  = con_stspag
            join USRSIHO.glwkrang stp on stp.ran_nomrep  = 'HPLREPPL' AND stp.ran_keyusu  = pi_usuario
                AND stp.ran_idepcc  = ps_terminal AND stp.ran_keypro  = 4 AND stp.ran_keydep  = con_stsplz
       WHERE glcoacar.aca_keyapr = dea_keyapr
         AND glcoacar.aca_keyusu = pi_usuario
         AND glcoacar.aca_actual = 'S'
         ) LOOP
     li_keyplz := rec3.con_keyplz;
     li_keyfol := rec3.con_keyfol;
     ls_keydep := rec3.con_keydep;
     ls_desdep := rec3.dep_desdep;
     ls_keypue := rec3.con_keypue;
     ls_despue := rec3.pue_despue;
     li_keyemp := rec3.con_keyemp;
     ls_nomemp := rec3.emp_nomemp;
     li_keytva := rec3.con_keytva;
     li_numcap := rec3.con_numcap;
     li_numcdi := rec3.con_numcdi;
     ls_keycia := rec3.cia_keycia;
     ls_descia := rec3.cia_descia;
     ls_keyapr := rec3.pam_cvesec;
     ls_desapr := rec3.pam_nompar;
     ln_cosuni := rec3.con_cosuni;
     ln_costot := rec3.costot;
     li_ctvplz := rec3.con_ctvplz;
--   obtiene los capitulos Que estan en el cotrato y los guarda en una
--   variable llamada ls_capitulos
     ls_capitulos := ' ';
     IF li_keytva = 1 THEN
   --  DBMS_OUTPUT.put_line('li_keyplz '||to_char(li_keyplz));
        FOR rec4 IN (SELECT coc_keycap
                     FROM   USRSIHO.holococa
                    WHERE   coc_keyplz = li_keyplz)
        LOOP
            li_numcap := rec4.coc_keycap;
     --       DBMS_OUTPUT.put_line('ls_capitulos '||ls_capitulos);
            if length(ls_capitulos) < 41 then
                ls_capitulos := ls_capitulos || TO_CHAR(li_numcap) || ',';
                -- ls_capitulos := 'AB' || 'CD' || ',';
            end if;
        END LOOP;
     END IF;
 ---- insercion por cada registro obtenido
     INSERT INTO USRSIHO.glwkcrys(cry_nomrep, cry_keyusu, cry_idepcc,
                          cry_numsec, cry_chr008, cry_chr004,
                          cry_chr009, cry_chr003, cry_dec006,
                          cry_chr001, cry_chr017, cry_dec007,
                          cry_dec008, cry_chr018, cry_chr002,
                          cry_chr019, cry_chr005, cry_chr006,
                          cry_dec001, cry_dec002, cry_dec009)
                   VALUES('HPLREPPL',pi_usuario,ps_terminal,
                          li_keyfol, ls_keydep, ls_desdep,
                          ls_keypue, ls_despue, li_keyemp,
                          ls_nomemp, li_keytva, li_numcap,
                          li_numcdi, ls_keycia, ls_descia,
                          ls_keyapr, ls_desapr, SUBSTR(ls_capitulos,1,40),
                          ln_cosuni, ln_costot, li_ctvplz);
     END LOOP;
   END IF;
-- borrar los registros recibidos para armar el Query
   DELETE FROM USRSIHO.glwkrang
    WHERE ran_nomrep  = 'HPLREPPL'
      AND ran_keyusu  = pi_usuario
      AND ran_idepcc  = ps_terminal;
END;
/
