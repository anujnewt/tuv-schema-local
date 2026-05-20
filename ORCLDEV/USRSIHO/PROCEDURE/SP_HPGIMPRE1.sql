CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_HPGIMPRE1" (wn_keypro IN NUMBER,
                                          wn_keyusu IN NUMBER,
                                          wn_keynom IN NUMBER,
                                          ws_numemi IN VARCHAR2,
                                          wn_lstemp IN NUMBER,
                                          ws_keyapr IN VARCHAR2,
                                          wn_limite IN NUMBER,
                                          ws_idepcc IN VARCHAR2,
                                          resultado OUT NUMBER)
 IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
  --resultado NUMBER(10);
   wn_keyemp NUMBER(10);
   wd_fecpag DATE;
   wn_import NUMBER(16,2);
   wn_year   NUMBER(5);
   wd_toDATE DATE;
   wn_sigreg NUMBER(10);
   wn_minreg NUMBER(10);
   wn_minreg2 NUMBER(10);
   wn_regexi NUMBER(10);
   wn_regnvo NUMBER(10);
   wn_maxreg NUMBER(10);
   wn_lugare NUMBER(10);
   wn_estatu NUMBER(5);
   wn_nomemi NUMBER(10);
   ws_nomemp VARCHAR2(150);
   wn_limstr NUMBER(5);
BEGIN
  resultado:= -11;
   -- si algun recibo perteneciente a la nomina y emisio, se le a asignado estatus <> 0  => cancela la nueva generacion
   SELECT count(*)
   INTO wn_nomemi
   FROM usrsiho.holoreci
   WHERE rec_keypro =  wn_keypro
     AND rec_keynom =  wn_keynom
     AND rec_numemi =  ws_numemi
     AND rec_keyapr =  ws_keyapr
     AND rec_stsrec <> 0;
   IF wn_nomemi>0 THEN
     resultado:= -1;-- RETURN /*-1*/;
   END IF;
   --lee el a??o de generacion del registro
   wd_todate := trunc(SYSDATE);
   wn_year := 0;
   --SELECT NVL(extract(year from per_fecpag),extract(year from wd_todate))
    BEGIN
        SELECT NVL(YEAR(per_fecpag), YEAR(SYSDATE))
        INTO wn_year
        FROM usrsiho.nmloperi
        WHERE per_keypro =  wn_keypro
         AND per_keynom =  wn_keynom
         AND per_nu3aux =  ws_keyapr
         AND per_nu4aux =  ws_numemi;
        EXCEPTION WHEN no_data_found THEN wn_year := YEAR(SYSDATE);
    END;
   --LET wn_year = year(wd_todate);
   --bloqueo de la tabla
---   LOCK TABLE holoreci IN EXCLUSIVE MODE;
   --lee la clave del recibo para iniciar la generacion si ya existen
    BEGIN
        SELECT MIN(rec_keyrec)
        INTO wn_minreg
        FROM usrsiho.holoreci
        WHERE rec_keypro=wn_keypro
         AND rec_keynom=wn_keynom
         AND rec_numemi=ws_numemi
         AND rec_keyapr=ws_keyapr;
        EXCEPTION WHEN no_data_found THEN wn_minreg := 0;
    END;
   --siguiente consecutivo temporal si ya existen de lo contrario el definitivo
    BEGIN
        SELECT MAX(rec_keyrec)
        INTO wn_sigreg
        FROM usrsiho.holoreci
        WHERE rec_keypro=wn_keypro
         AND rec_ejerci=wn_year;
        EXCEPTION WHEN no_data_found THEN wn_sigreg := 0;
    END;
   --keyrec de inicio
   wn_maxreg:=wn_sigreg;
   --si no hay registros > iniciar en 1
   IF wn_sigreg IS NULL THEN
     wn_sigreg:=0;
   END IF;
   --primer keyrec a insertar
   wn_sigreg:=wn_sigreg+1;
   --elimina los recibos (para este proceso,nomina,emision y ubicacion) en caso de existir
   DELETE
   FROM usrsiho.holoreci
   WHERE rec_keypro=wn_keypro
     AND rec_keynom=wn_keynom
     AND rec_numemi=ws_numemi
     AND rec_keyapr=ws_keyapr;
   --numero de recibos eliminados
   wn_regexi:=sql%rowcount;
   --inicializacion de la cuenta de registros
   wn_regnvo:=0;
   wn_minreg2:=wn_sigreg;
--sum(sp_DECODEnum(his_codimp,'01',his_import,his_import * -1))
-- sp_ordenrec(sum(SP_DECODENUM(his_codimp,'01',his_import,his_import * -1)),wn_limite,emp_cveban)
   FOR rec IN (SELECT his_keyemp,per_fecpag,
              sum(decode(his_codimp,'01',his_import,his_import * -1)) total,
              emp_nomemp
           FROM usrsiho.nmlohism,usrsiho.nmloperi,usrsiho.nmloconc,usrsiho.nmcoempl
           WHERE his_keypro = wn_keypro
             AND his_keypro = per_keypro
             AND his_keyper = per_keyper
             AND his_keycon = con_keycon
             AND his_keyemp = emp_keyemp
             AND his_codimp in ('01','02')
             AND per_keynom = wn_keynom
             AND per_nu4aux = ws_numemi
             AND per_nu3aux = ws_keyapr
                AND ( (wn_lstemp > 0 AND his_keyemp IN (SELECT ran_keyemp
                                                     FROM glwkrang
                                                     WHERE ran_nomrep = 'hpgimpre1'
                                                       AND ran_idepcc = ws_idepcc
                                                       AND ran_keyusu = wn_keyusu
                                                     )
                ) OR
                 wn_lstemp = 0 )
           GROUP by his_keyemp, per_fecpag, emp_nomemp, emp_cveban
            ORDER BY emp_nomemp asc) LOOP
          -- ORDER BY limite desc,emp_nomemp asc) LOOP
       --GROUP by  his_keyemp,per_fecpag,emp_nomemp,emp_cveban
       --ORDER BY limite desc,emp_nomemp asc
      -- Solo si el importe es mayor a cero => se genera el recibo
      wn_keyemp := rec.his_keyemp;
      wd_fecpag := rec.per_fecpag;
      wn_import := rec.total;
      ws_nomemp := rec.emp_nomemp;
      --wn_limite := rec.limite;
      IF wn_import > 0 THEN
         --convierte el valor a cadena
        -- ws_keyapr := '' || ws_keyapr;
         --estatus del recibo
         wn_estatu := sp_hstsrec1(wn_keypro,ws_keyapr,wn_keynom,ws_numemi,wn_keyemp);
         ---inserccion de registros
         INSERT INTO usrsiho.holoreci(rec_ejerci,rec_keypro,rec_keyrec,rec_keyemp,rec_keyapr,rec_keynom,
                              rec_numemi,rec_stsrec,rec_import,rec_fecpag,rec_feccob,rec_keyusg,
                              rec_fecact,rec_keyusc,rec_keypol,rec_stsfis,rec_fecfis,rec_remtra,
                              rec_stsfon,rec_stscon,rec_impiva,rec_impisr)
         VALUES(wn_year,wn_keypro,wn_sigreg,wn_keyemp,ws_keyapr,wn_keynom,
                ws_numemi,'0',wn_import,wd_fecpag,NULL,wn_keyusu,
                wd_todate,NULL,NULL,'0',NULL,NULL,0,wn_estatu,0,NULL);
         --evaluar el siguente consecutivo
         wn_sigreg := wn_sigreg + 1;
         --incrementa el contador del numero de registros
         wn_regnvo := wn_regnvo + 1;
      END IF;
   END LOOP;
   --si se eliminaron recibos y los insertados fueron un numero mayor o igual => actualizacion de rec_keyrec
   IF wn_regexi>0 THEN
      --verIFica si es posible insertar los recibos nuevos en el hueco generados por la eliMINacion
      SELECT count(*)
      INTO wn_lugare
      FROM usrsiho.holoreci
      WHERE rec_keyrec between wn_minreg
       AND wn_minreg + wn_regnvo - 1
       AND rec_keypro = wn_keypro
       AND rec_ejerci = wn_year;
      IF wn_lugare=0 THEN
         UPDATE holoreci
         SET rec_keyrec = wn_minreg + rec_keyrec - wn_minreg2
         WHERE rec_keypro=wn_keypro
           AND rec_keynom=wn_keynom
           AND rec_numemi=ws_numemi
           AND rec_keyapr=ws_keyapr;
      END IF;
   END IF;
   --liberacion de la tabla
--   UNLOCK TABLE holoreci;
   -- Elimina rangos
   DELETE
   FROM usrsiho.glwkrang
   WHERE ran_nomrep = 'hpgimpre1'
     AND ran_idepcc = ws_idepcc
     AND ran_keyusu = wn_keyusu;
   --regresa el numero de registros insertados
   resultado:= wn_regnvo;
END;
/
