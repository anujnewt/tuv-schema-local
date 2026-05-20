CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_HOLOALTINC" (pi_keyemp NUMBER,         --Numero de empleado
                                          pi_tipgra NUMBER,        --Opci??n de grabado.
                                          li_secrph NUMBER,         --Numero de RPH
                                          pd_fechaact DATE,          --Fecha de actualizaci??n
                                          ps_keyvia VARCHAR2,     --Clave del viatico
                                          pd_costvia NUMBER,  --Costo del viatico
                                          pi_keyusu NUMBER,         --Clave del usuario
                                          pi_num_id NUMBER,         --Clave de la hoja de trabajo
                                          pi_serial NUMBER,         --Clave del detalle de la hoja de trabajo
                                          pi_keypro NUMBER,        --Numero del proceso
                                          pi_capini NUMBER,        --Numero del capitulo inicial
                                          pi_capfin NUMBER,        --Numero del capitulo final
                                          pi_hraent NUMBER,         --Minutos de la hr de entrada
                                          pi_hrasal NUMBER,         --Minutos de la hr de salida
                                          pi_mincom NUMBER,         --Minutos de la hr de comida
                                          pi_numreg NUMBER,         --Numero de registro la tabla temporal para saber que registro actualizar
                                          pi_unreg NUMBER          --Marca si solo es un capitulo
                                         ) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
--RETURNING INTEGER,VARCHAR2(30),VARCHAR2(20);
-- -----------------------------------------------------------------
-- sp_holoaltinc: Este stored procedure es el que utiliza en el
-- stored procedure principal 'sp_holotrarph' que sirve para
-- grabar el detalle de las incidencias a los RPH generados
-- Recibe como parametro principal la hoja de trabajo y el numero de registro, asi como el tipo
-- de incidencia que se va a procesar, esto para calcular la actividad.
-- Realizado el 29 de Septiembre de 2005
-- Emilio Pulido Rangel
-- MODIFICO:                    COMENTARIO:       FECHA:
-- Juan Carlos Reyes O.         Se agrego la consulta y validaci??n  19/07/2011
--                              del calculo de la edad del actor.
--                              Separacion de actividades segun el  19/09/2011
--                              tipo de incidencia a grabar.
-- -----------------------------------------------------------------
 pd_cosuni NUMBER(15,2);
 ps_regrfc VARCHAR2(13);              --RFC del empleado
 ps_recurp VARCHAR2(18);              --CURP del empleado
 ps_keydep VARCHAR2(16);
 pi_keytco NUMBER(10);
 pi_keyfol NUMBER(10);
 pi_keygdp NUMBER(10);
 pi_keypue VARCHAR2(16);
 ps_mensaje1 VARCHAR2(30);
 ps_mensaje2 VARCHAR2(20);
 pi_diafest NUMBER(10);
 pi_markadf NUMBER(10);
 ps_tipoinc VARCHAR2(2);
--Variables para obtener el numero de capitulo de los viaticos
 i NUMBER(10);
 longitud NUMBER(10);
 inicio NUMBER(10);fin NUMBER(10);
 pi_capitulo NUMBER(10);
 caracter VARCHAR2(1);
 cadena VARCHAR2(20);
 ps_keyconvia VARCHAR2(20);    --Clave del viatico
--VARIABLES PARA EL CALCULO DE MENORES DE EDAD
 Ld_MenorEdad NUMBER(10);
 Ls_Nacionalidad VARCHAR2(2);
 Li_CodigoAnda NUMBER(10);
 Ld_Anios NUMBER(10);
 Pd_FecGra DATE;
 Ls_descvia VARCHAR2(20);
BEGIN
ps_mensaje1 := '';
ps_mensaje2 := '';
pd_cosuni := 0;
ps_regrfc := '';
ps_recurp := '';
ps_keydep := '';
pi_keytco := 0;
pi_keyfol := 0;
pi_keygdp := 0;
pi_keypue := '';
pi_diafest := 0;
pi_markadf := 0;
ps_tipoinc := '';
ps_keyconvia := ps_keyvia;
--Inicializaci??n de variables para obtener el n??mero de capitulo de los viaticos
i := 1;
inicio := 1;
fin := 0;
pi_capitulo := 0;
caracter := '';
cadena := '';
--INICIALIZACION DE VARIABLES DEL CALCULO DE MENORES DE EDAD
Ld_MenorEdad := 0;
Ls_Nacionalidad := '';
Li_CodigoAnda := 0;
Ld_Anios := 0;
Pd_FecGra := '01/01/1900';
Ls_descvia := '';
---------------------------------------------------
-- //INICIO CONS-0530 Mejoras SAI Juan Carlos Reyes Olivera 19/09/2011
---------------------------------------------------
--INSERT INTO BORRA VALUES(1,'pi_keyemp',pi_keyemp,'');
--INSERT INTO BORRA VALUES(2,'pi_tipgra',pi_tipgra,'');
--INSERT INTO BORRA VALUES(3,'pi_num_id',pi_num_id,'');
--INSERT INTO BORRA VALUES(4,'pi_serial',pi_serial,'');
   -- -----------------------------------------------------
   -- Obtenemos los a??os considerados para el menor de edad
   -- -----------------------------------------------------
   SELECT NVL(pam_folini,0)
     into Ld_MenorEdad
     FROM USRSIHO.GLCOPAMS
    WHERE pam_keypar = 'TEME';
   -- -----------------------------------------------------
   -- Obtenemos la nacionalidad del empleado
   -- -----------------------------------------------------
    SELECT emp_ca3aux
      INTO Ls_Nacionalidad
      FROM USRSIHO.NMCOEMPL
     WHERE emp_keyemp = pi_KeyEmp;
   -- -----------------------------------------------------
   -- Obtenemos el codigo de la ANDA
   -- -----------------------------------------------------
    SELECT to_number(pam_folini)
      INTO Li_CodigoAnda
      FROM USRSIHO.glcopams
     WHERE pam_keypar = 'ACP'
       AND pam_folfin = 'CODIGO ANDA';
   -- -----------------------------------------------------
   -- Obtenemos la fecha de grabacion de la HT
   -- -----------------------------------------------------
    SELECT enc_fecgra
      INTO Pd_FecGra
      FROM USRSIHO.holoenctra
    WHERE enc_num_id = pi_num_id;
   -- --------------------------------------------------------------------
   -- Calculamos la edad del empleado para determinar si es menor de edad
   -- --------------------------------------------------------------------
   IF ls_Nacionalidad = '02' THEN
       SELECT trunc(to_number((Pd_FecGra - ale_fecnac)/365.25))
         INTO Ld_Anios
         FROM USRSIHO.HOLOALEM
        WHERE ale_keyemp = pi_KeyEmp;
   ELSE
       IF Li_CodigoAnda <> pi_KeyEmp THEN
            SELECT CASE WHEN to_number(substr(emp_regrfc,7,2)) > 0 AND to_number(substr(emp_regrfc,9,2)) > 0 AND to_number(substr(emp_regrfc,5,2)) >= 0 THEN
                        trunc( nvl(to_number((Pd_FecGra - TO_DATE(substr(emp_regrfc,7,2) || '/' || substr(emp_regrfc,9,2) || '/' || case when to_number(substr(emp_regrfc,5,2)) >= (extract(year from Pd_FecGra)-2000) then '19' else '20' end || substr(emp_regrfc,5,2)))/365.25),0) )
                   ELSE
                         99
                   END
              INTO Ld_Anios
              FROM USRSIHO.nmcoempl
             WHERE emp_keyemp = pi_KeyEmp;
       ELSE
            Ld_Anios := 99;
       END IF;
   END IF;
--INSERT INTO BORRA VALUES(5,'Ld_Anios',Ld_Anios,'');
---------------------------------------------------
-- //FIN CONS-0530 Mejoras SAI Juan Carlos Reyes Olivera 19/09/2011
---------------------------------------------------
SELECT emp_regrfc,emp_recurp
INTO   ps_regrfc,ps_recurp
FROM USRSIHO.NMCOEMPL
WHERE emp_keyemp = pi_keyemp;
IF pi_tipgra = 1 THEN --Graba los viaticos (De sindicato ANDA y OTROS)
   --Unificaci??n de Conceptos
   Ls_descvia := substr(ps_keyconvia,4,17);
   ps_keyconvia := substr(ps_keyconvia,1,3);
   SELECT pam_cvesec
   INTO   pi_keypue
   FROM USRSIHO.glcopams,USRSIHO.nmcopues
   WHERE pam_folfin = pue_keypue AND
         pam_keypar = 'AJEV' AND
         pam_folini = 'GM' AND
         pam_nompar = Ls_descvia;
         --pam_folfin = (
         --              SELECT det_keypue
         --              FROM HOLODETTRA
         --              WHERE det_num_id = pi_num_id AND
         --                    det_serial = pi_serial
         --             );
   SELECT det_capgra
   INTO cadena
   FROM USRSIHO.HOLODETTRA
   WHERE det_num_id = pi_num_id AND
         det_serial = pi_serial;
   longitud := LENGTH(cadena);
     FOR i IN 1..longitud LOOP
      caracter := SUBSTR(CADENA , i , 1);
      IF caracter = ',' THEN
         fin := i - 1;
         pi_capitulo := SUBSTR(CADENA , inicio , fin);
         inicio := i + 1;
         EXIT;
      END IF;
      IF i = longitud THEN
         fin := longitud;
         pi_capitulo := SUBSTR(CADENA , inicio , fin);
         EXIT;
      END IF;
   END LOOP;
   pi_capitulo := NVL(pi_capitulo,0);
   INSERT INTO USRSIHO.HOLOGDPR
   (gdp_keydep,gdp_keyrph,gdp_fechag,gdp_keyemp,gdp_regrfc,gdp_recurp,gdp_keypue,gdp_capini,gdp_capfin,
   gdp_numcap,gdp_keycon,gdp_marcon,gdp_marcos,gdp_cosuni,gdp_keysue,gdp_keytco,gdp_keyfol,gdp_keyusu,
   gdp_minleg,gdp_minsal,gdp_minext,gdp_mincom)
   --SELECT det_keydep,li_secrph,pd_fechaact,NVL(det_keyemp,0),ps_regrfc,ps_recurp,pi_keypue,pi_capitulo,pi_capitulo,
   --1,ps_keyconvia,'X','X',NVL(pd_costvia,0),0,NVL(det_keytco,0),NVL(det_keyfol,0),pi_keyusu,
   SELECT det_keydep,li_secrph,pd_fechaact,NVL(det_keyemp,0),ps_regrfc,ps_recurp,pi_keypue,pi_capitulo,pi_capitulo,
   1,ps_keyconvia,'X','X',NVL(pd_costvia,0),0,0,0,pi_keyusu,
   0,0,0,0
   FROM USRSIHO.HOLODETTRA
   WHERE det_num_id = pi_num_id AND
         det_serial = pi_serial;
--   LET ps_mensaje1 = 'ANDA Det viaticos';
--   LET ps_mensaje2 = '';
--   RETURN li_secrph,ps_mensaje1,ps_mensaje2 WITH RESUME;
ELSE
   SELECT det_keydep,det_keytco,det_keyfol
   INTO   ps_keydep,pi_keytco,pi_keyfol
   FROM USRSIHO.HOLODETTRA
   WHERE det_num_id = pi_num_id AND
         det_serial = pi_serial;
--Codigo nuevo sin la validacion del usuario
begin
   SELECT NVL(TAB.TAB_IMPORT,0)
   INTO pd_cosuni
   FROM USRSIHO.HOLOCONT CONT, USRSIHO.NMCOEMPL EMPL, USRSIHO.NMCOPUES PUES, USRSIHO.NMLOCONC CON,
        USRSIHO.HOLOTABS TAB, USRSIHO.HOLOFRPH, USRSIHO.NMLOALDE AL
   WHERE CONT.CON_KEYEMP = EMPL.EMP_KEYEMP
     AND CONT.CON_KEYPUE = PUES.PUE_KEYPUE
     AND CONT.CON_KEYDEP = AL.ALD_KEYDEP
     AND pue_nu1aux <> '2'
     AND AL.ALD_STATUS = 'A'
     AND CON.CON_KEYCON = PUES.PUE_CA5AUX
--     AND CONT.CON_STSPAG = 'V'
     AND TRIM(CONT.CON_KEYDEP) = ps_keydep
     AND CONT.CON_KEYTCO = pi_keytco
     AND CONT.CON_KEYFOL = pi_keyfol
     AND CONT.CON_KEYEMP = pi_keyemp
     AND TAB.TAB_KEYPRO =  pi_keypro
     AND TAB.TAB_KEYPUE = CONT.CON_KEYPUE
     AND TAB.TAB_PERTRA = CONT.CON_PERTRA
     AND TAB.TAB_IDIOMA = CONT.CON_IDIOMA
     AND TAB.TAB_KEYNAC = CONT.CON_KEYNAC
--     AND TAB.TAB_KEYTAB = CONT.CON_KEYTCO - 1
     AND TAB.TAB_KEYTAB = (CASE WHEN CONT.CON_KEYTCO = 519 THEN 3 ELSE CONT.CON_KEYTCO END - 1)
     AND FRP_KEYRPH = li_secrph
     AND TAB.TAB_FECINI <= FRP_FECTRAB
     AND NVL(TAB.TAB_FECFIN,FRP_FECTRAB) >= FRP_FECTRAB;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
      pd_cosuni := 0;
  END;
-- Codigo anterior validando el usuario
--   SELECT NVL(TAB.TAB_IMPORT,0)
--   INTO pd_cosuni
--   FROM HOLOCONT CONT, NMCOEMPL EMPL, NMCOPUES PUES, NMLOCONC CON,
--   GLCOACTC ACT, HOLOTABS TAB, HOLOFRPH, NMLOALDE AL
--   WHERE CONT.CON_KEYEMP = EMPL.EMP_KEYEMP
--     AND CONT.CON_KEYPUE = PUES.PUE_KEYPUE
--     AND CONT.CON_KEYDEP = AL.ALD_KEYDEP
--     AND pue_nu1aux <> '2'
--     AND AL.ALD_STATUS = 'A'
--     AND CON.CON_KEYCON = PUES.PUE_CA5AUX
--     AND ACT.ACT_KEYTCO = CONT.CON_KEYTCO
--     AND CONT.CON_STSPAG = 'V'
--     AND TRIM(CONT.CON_KEYDEP) = ps_keydep
--     AND ACT.ACT_KEYUSU = pi_keyusu
--     AND CONT.CON_KEYTCO =  pi_keytco
--     AND CONT.CON_KEYFOL =  pi_keyfol
--     AND TAB.TAB_KEYPRO = pi_keypro
--     AND TAB.TAB_KEYPUE = CONT.CON_KEYPUE
--     AND TAB.TAB_PERTRA = CONT.CON_PERTRA
--     AND TAB.TAB_IDIOMA = CONT.CON_IDIOMA
--     AND TAB.TAB_KEYNAC = CONT.CON_KEYNAC
--     AND TAB.TAB_KEYTAB = CONT.CON_KEYTCO - 1
--     AND FRP_KEYRPH = li_secrph
--     AND TAB.TAB_FECINI <= FRP_FECTRAB
--     AND NVL(TAB.TAB_FECFIN,FRP_FECTRAB) >= FRP_FECTRAB;
   IF pi_tipgra = 2 THEN --Graba la incidencia Normal (De sindicato ANDA y OTROS)
      INSERT INTO USRSIHO.HOLOGDPR
      (gdp_keydep,gdp_keyrph,gdp_fechag,gdp_keyemp,gdp_regrfc,gdp_recurp,gdp_keypue,gdp_capini,gdp_capfin,
      gdp_numcap,gdp_keycon,gdp_marcon,gdp_marcos,gdp_cosuni,gdp_keysue,gdp_keytco,gdp_keyfol,gdp_keyusu,
      gdp_minleg,gdp_minsal,gdp_minext,gdp_mincom)
      SELECT det_keydep,li_secrph,pd_fechaact,NVL(det_keyemp,0),ps_regrfc,ps_recurp,det_keypue,
      CASE
           WHEN pi_unreg = 1 AND NVL(pi_capini,0) = 0 THEN to_number(det_capgra)
           WHEN pi_unreg = 1 AND NVL(pi_capini,0) > 0 THEN NVL(pi_capini,0)
           WHEN pi_unreg = 0 AND NVL(pi_capini,0) = 0 THEN det_capini
           WHEN pi_unreg = 0 AND NVL(pi_capini,0) > 0 THEN NVL(pi_capini,0)
           ELSE 0
      END,
      CASE
           WHEN pi_unreg = 1 AND NVL(pi_capfin,0) = 0 THEN to_number(det_capgra)
           WHEN pi_unreg = 1 AND NVL(pi_capfin,0) > 0 THEN NVL(pi_capfin,0)
           WHEN pi_unreg = 0 AND NVL(pi_capfin,0) = 0 THEN det_capfin
           WHEN pi_unreg = 0 AND NVL(pi_capfin,0) > 0 THEN NVL(pi_capfin,0)
           ELSE 0
      END,
      (CASE
            WHEN pi_unreg = 1 AND NVL(pi_capfin,0) = 0 THEN to_number(det_capgra)
            WHEN pi_unreg = 1 AND NVL(pi_capfin,0) > 0 THEN NVL(pi_capfin,0)
            WHEN pi_unreg = 0 AND NVL(pi_capfin,0) = 0 THEN det_capfin
            WHEN pi_unreg = 0 AND NVL(pi_capfin,0) > 0 THEN NVL(pi_capfin,0)
            ELSE 0
       END -
       CASE
            WHEN pi_unreg = 1 AND NVL(pi_capini,0) = 0 THEN to_number(det_capgra)
            WHEN pi_unreg = 1 AND NVL(pi_capini,0) > 0 THEN NVL(pi_capini,0)
            WHEN pi_unreg = 0 AND NVL(pi_capini,0) = 0 THEN det_capini
            WHEN pi_unreg = 0 AND NVL(pi_capini,0) > 0 THEN NVL(pi_capini,0)
            ELSE 0
       END) + 1,
      CASE WHEN Ld_Anios < Ld_MenorEdad THEN 'HTI' ELSE det_keycon END,   -- CONS-0530 Mejoras SAI Juan Carlos Reyes Olivera 19/09/2011
      'S','S',
      NVL(pd_cosuni,0),
      0,NVL(det_keytco,0),NVL(det_keyfol,0),pi_keyusu,
      pi_hraent,pi_hrasal,0,pi_mincom
      FROM USRSIHO.HOLODETTRA
      WHERE det_num_id = pi_num_id AND
            det_serial = pi_serial;
      SELECT HOLOGDPR_seq.currval INTO pi_keygdp FROM dual;
--      UPDATE HOLOGDPR
--      SET gdp_cosuni = NVL(gdp_cosuni,0) * NVL(gdp_numcap,0)
--      WHERE gdp_keyrph = li_secrph AND
--            gdp_keysec = pi_keygdp;
--      LET ps_mensaje1 = 'ANDA Det viaticos';
--      LET ps_mensaje2 = '';
--      RETURN li_secrph,ps_mensaje1,ps_mensaje2 WITH RESUME;
      IF pi_capini <> pi_capfin THEN --Actualiza cuando son varios capitulos continuos
         UPDATE USRSIHO.HOLOCOCA
         SET coc_keyrph = li_secrph,
             coc_keygdp = pi_keygdp
         WHERE coc_keycap IN (SELECT capitulo FROM USRSIHO.TMP_HOLOGDPR) AND
                                     coc_hjatra = pi_num_id AND
                                     coc_keyplz =
                                                 (SELECT con_keyplz
                                                  FROM USRSIHO.HOLOCONT
                                                  WHERE con_keyfol = pi_keyfol AND
                                                        con_keyemp = pi_keyemp)
               AND coc_hjatra = pi_num_id;
         DELETE FROM USRSIHO.TMP_HOLOGDPR;
      ELSE
         IF pi_numreg <> 0  THEN --Actualiza cuando son varios capitulos salteados
            IF pi_unreg = 0 THEN
               UPDATE USRSIHO.HOLOCOCA
               SET coc_keyrph = li_secrph,
                   coc_keygdp = pi_keygdp
               WHERE coc_keycap = (SELECT capitulo FROM USRSIHO.TMP_HOLOGDPR WHERE keycapitulo = pi_numreg) AND
                     coc_hjatra = pi_num_id AND
                     coc_keyplz =
                                (SELECT con_keyplz
                                 FROM USRSIHO.HOLOCONT
                                 WHERE con_keyfol = pi_keyfol AND
                                       con_keyemp = pi_keyemp);
            ELSE --Actualiza cuando es un solo capitulo
               UPDATE USRSIHO.HOLOCOCA
               SET coc_keyrph = li_secrph,
                   coc_keygdp = pi_keygdp
               WHERE coc_keycap = pi_numreg AND
                     coc_hjatra = pi_num_id AND
                     coc_keyplz =
                                (SELECT con_keyplz
                                 FROM USRSIHO.HOLOCONT
                                 WHERE con_keyfol = pi_keyfol AND
                                       con_keyemp = pi_keyemp);
            END IF;
         END IF;
      END IF;
   END IF;
   IF pi_tipgra = 3 THEN --Graba la incidencia diferente de normal (De sindicato ANDA Y OTROS)
      SELECT NVL(to_number(substr(det_auxca2,8,1)),0),det_tipinc
      INTO pi_markadf,ps_tipoinc
      FROM USRSIHO.HOLODETTRA
      WHERE det_num_id = pi_num_id AND
            det_serial = pi_serial;
      IF (ps_tipoinc = 'JE' OR ps_tipoinc = 'JV') AND pi_markadf = 1 THEN
         SELECT NVL(COUNT(*),0) NoReg
         INTO pi_diafest
         FROM USRSIHO.glcopams
         WHERE pam_keypar = 'CDF' AND
               pam_folfin IN (
                              SELECT SUBSTR(to_char(det_fecgra) , 4 , 2) || '/' || SUBSTR(to_char(det_fecgra) , 1 , 2) || '/' || SUBSTR(to_char(det_fecgra) , 7 , 4)
                              FROM USRSIHO.HOLODETTRA
                              WHERE det_num_id = pi_num_id AND
                                    det_serial = pi_serial
                             );
         IF pi_diafest > 0 THEN
            SELECT pue_ca5aux
            INTO ps_keyconvia
            FROM USRSIHO.nmcopues
            WHERE pue_keypue =
                             (SELECT pam_cvesec
                              FROM USRSIHO.glcopams
                              WHERE pam_keypar = 'AJEV' AND
                                    pam_folini ='DF' AND
                                    pam_folfin =
                                               (SELECT det_keypue
                                                FROM USRSIHO.HOLODETTRA
                                                WHERE det_num_id = pi_num_id AND
                                                      det_serial = pi_serial
                                               )
                             );
            SELECT pam_cvesec
            INTO pi_keypue
            FROM USRSIHO.glcopams
            WHERE pam_keypar = 'AJEV' AND
                  pam_folini ='DF' AND
                  pam_folfin =
                             (SELECT det_keypue
                              FROM USRSIHO.HOLODETTRA
                              WHERE det_num_id = pi_num_id AND
                                    det_serial = pi_serial
                             );
            INSERT INTO USRSIHO.HOLOGDPR
            (gdp_keydep,gdp_keyrph,gdp_fechag,gdp_keyemp,gdp_regrfc,gdp_recurp,gdp_keypue,gdp_capini,gdp_capfin,
            gdp_numcap,gdp_keycon,gdp_marcon,gdp_marcos,gdp_cosuni,gdp_keysue,gdp_keytco,gdp_keyfol,gdp_keyusu,
            gdp_minleg,gdp_minsal,gdp_minext,gdp_mincom)
            SELECT det_keydep,li_secrph,pd_fechaact,NVL(pi_keyemp,0),ps_regrfc,ps_recurp,det_keypue,det_capini,det_capfin,
            1,
            det_keycon,               -- CONS-0530 Mejoras SAI Juan Carlos Reyes Olivera 19/09/2011
            'X','X',NVL(det_cosuni,0),'0',0,0,pi_keyusu,
            0,0,0,0
            FROM USRSIHO.HOLODETTRA
            WHERE det_num_id = pi_num_id AND
                  det_serial = pi_serial;
            INSERT INTO USRSIHO.HOLOGDPR
            (gdp_keydep,gdp_keyrph,gdp_fechag,gdp_keyemp,gdp_regrfc,gdp_recurp,gdp_keypue,gdp_capini,gdp_capfin,
            gdp_numcap,gdp_keycon,gdp_marcon,gdp_marcos,gdp_cosuni,gdp_keysue,gdp_keytco,gdp_keyfol,gdp_keyusu,
            gdp_minleg,gdp_minsal,gdp_minext,gdp_mincom)
            SELECT det_keydep,li_secrph,pd_fechaact,NVL(pi_keyemp,0),ps_regrfc,ps_recurp,pi_keypue,det_capini,det_capfin,
            1,
            CASE WHEN Ld_Anios < Ld_MenorEdad THEN 'HTI' ELSE ps_keyconvia END, -- CONS-0530 Mejoras SAI Juan Carlos Reyes Olivera 19/09/2011
            'X','X',NVL(det_cosuni,0),'0',0,0,pi_keyusu,
            0,0,0,0
            FROM USRSIHO.HOLODETTRA
            WHERE det_num_id = pi_num_id AND
                  det_serial = pi_serial;
            INSERT INTO USRSIHO.HOLOGDPR
            (gdp_keydep,gdp_keyrph,gdp_fechag,gdp_keyemp,gdp_regrfc,gdp_recurp,gdp_keypue,gdp_capini,gdp_capfin,
            gdp_numcap,gdp_keycon,gdp_marcon,gdp_marcos,gdp_cosuni,gdp_keysue,gdp_keytco,gdp_keyfol,gdp_keyusu,
            gdp_minleg,gdp_minsal,gdp_minext,gdp_mincom)
            SELECT det_keydep,li_secrph,pd_fechaact,NVL(pi_keyemp,0),ps_regrfc,ps_recurp,pi_keypue,det_capini,det_capfin,
            1,
            CASE WHEN Ld_Anios < Ld_MenorEdad THEN 'HTI' ELSE ps_keyconvia END, -- CONS-0530 Mejoras SAI Juan Carlos Reyes Olivera 19/09/2011
            'X','X',NVL(det_cosuni,0),'0',0,0,pi_keyusu,
            0,0,0,0
            FROM USRSIHO.HOLODETTRA
            WHERE det_num_id = pi_num_id AND
                  det_serial = pi_serial;
         ELSE
            INSERT INTO USRSIHO.HOLOGDPR
            (gdp_keydep,gdp_keyrph,gdp_fechag,gdp_keyemp,gdp_regrfc,gdp_recurp,gdp_keypue,gdp_capini,gdp_capfin,
            gdp_numcap,gdp_keycon,gdp_marcon,gdp_marcos,gdp_cosuni,gdp_keysue,gdp_keytco,gdp_keyfol,gdp_keyusu,
            gdp_minleg,gdp_minsal,gdp_minext,gdp_mincom)
            SELECT det_keydep,li_secrph,pd_fechaact,NVL(pi_keyemp,0),ps_regrfc,ps_recurp,det_keypue,det_capini,det_capfin,
            1,
            det_keycon              , -- CONS-0530 Mejoras SAI Juan Carlos Reyes Olivera 19/09/2011
            'X','X',NVL(det_cosuni,0),'0',0,0,pi_keyusu,
            0,0,0,0
            FROM USRSIHO.HOLODETTRA
            WHERE det_num_id = pi_num_id AND
                  det_serial = pi_serial;
         END IF;
      ELSE
         IF (ps_tipoinc = 'PA' OR ps_tipoinc = 'VL' OR ps_tipoinc = 'DE' OR ps_tipoinc = 'CM' OR
             ps_tipoinc = 'CN' OR ps_tipoinc = 'TA' OR ps_tipoinc = 'TE' OR ps_tipoinc = 'ED'
             OR ps_tipoinc = 'DF' OR ps_tipoinc = 'SD' OR ps_tipoinc = 'TS') THEN
            --Obtiene el capitulo inicial de las Incidencias Extemporaneas
            SELECT det_capgra
            INTO cadena
            FROM USRSIHO.HOLODETTRA
            WHERE det_num_id = pi_num_id AND
                  det_serial = pi_serial;
            longitud := LENGTH(cadena);
             FOR i IN 1..longitud LOOP
               caracter := SUBSTR(CADENA , i , 1);
               IF caracter = ',' THEN
                  fin := i - 1;
                  pi_capitulo := SUBSTR(CADENA , inicio , fin);
                  inicio := i + 1;
                  EXIT;
               END IF;
               IF i = longitud THEN
                  fin := longitud;
                  pi_capitulo := SUBSTR(CADENA , inicio , fin);
                  EXIT;
               END IF;
            END loop;
            pi_capitulo := NVL(pi_capitulo,0);
         END IF;
         INSERT INTO USRSIHO.HOLOGDPR
         (gdp_keydep,gdp_keyrph,gdp_fechag,gdp_keyemp,gdp_regrfc,gdp_recurp,gdp_keypue,gdp_capini,gdp_capfin,
         gdp_numcap,gdp_keycon,gdp_marcon,gdp_marcos,gdp_cosuni,gdp_keysue,gdp_keytco,gdp_keyfol,gdp_keyusu,
         gdp_minleg,gdp_minsal,gdp_minext,gdp_mincom)
         SELECT det_keydep,li_secrph,pd_fechaact,NVL(pi_keyemp,0),ps_regrfc,ps_recurp,det_keypue,CASE WHEN pi_capitulo = 0 THEN det_capini ELSE pi_capitulo END,CASE WHEN pi_capitulo = 0 THEN det_capfin ELSE pi_capitulo END,
         -- INICIA CONS-0530 Mejoras SAI Juan Carlos Reyes Olivera 19/09/2011
         1,CASE WHEN Ld_Anios < Ld_MenorEdad AND ps_tipoinc = 'TA' THEN 'HTI'
                WHEN Ld_Anios < Ld_MenorEdad AND ps_tipoinc = 'TE' THEN 'HIT'
                WHEN Ld_Anios < Ld_MenorEdad AND ps_tipoinc = 'ED' THEN 'HTI'
                ELSE det_keycon
           END,
         -- FIN CONS-0530 Mejoras SAI Juan Carlos Reyes Olivera 19/09/2011
         'X','X',NVL(det_cosuni,0),'0',0,0,pi_keyusu,
         0,0,0,0
         FROM USRSIHO.HOLODETTRA
         WHERE det_num_id = pi_num_id AND
               det_serial = pi_serial;
--   LET ps_mensaje1 = 'ANDA Det viaticos';
--   LET ps_mensaje2 = '';
--   RETURN li_secrph,ps_mensaje1,ps_mensaje2 WITH RESUME;
     END IF;
   END IF;
END IF;
--INSERT INTO BORRA VALUES(6,'Termino el proceso',0,'sin errores');
END;
/
