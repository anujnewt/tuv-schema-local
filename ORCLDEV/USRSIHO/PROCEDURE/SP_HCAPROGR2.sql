CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_HCAPROGR2" (vs_ide_pcc VARCHAR2,  -- Identif. PC
             vn_key_usu NUMBER,   -- Clave de usuario
             vs_log_usu VARCHAR2,  -- Login del usuario
             vs_key_men VARCHAR2,  -- Nombre del menu
             vn_ran_ini NUMBER,   -- Rango inicial
             vn_ran_fin NUMBER,   -- Rango final
             vs_key_dep VARCHAR2) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start

-- PGV moved types end
   -- Clave de departamento
  -- Estandares y Desarrollo
  --
  -- Sistema  : RH-2000  C/S
  -- Modulo   : Nomina de Honorarios(ho)
  -- Programa : sp_hcaprogr2
  --            Eliminacion de capitulos por rangos
  -- Autor    : Emilio Pulido Rangel
  -- Fecha    : 10 de Diciembre de 2001
   vn_con_001    NUMBER(5);
                 -- Contador de registros
   vn_capitulos  NUMBER(5);
                 -- Contador de capitulos para la primer validaci??   DEFINE vn_rescapi    SMALLINT;
                 -- Resta de capitulos
   vn_rescapi    NUMBER(5);
   vs_cadena     VARCHAR2(15);                  -- Variable para la bitacora
   vpre_status   VARCHAR2(1);
   vn_key_plz    holocont.con_keyplz%TYPE;  -- Clave de plaza
   vs_keydep     holocont.con_keydep%TYPE;  -- Clave de departamento
   vn_cos_uni    holocont.con_cosuni%TYPE;  -- Costo unitario del Capitulo
   vs_key_pue    holocont.con_keypue%TYPE;  -- Clave de Puesto o Actividad
   vs_sts_pag    holococa.coc_stspag%TYPE;  -- status capitulo
   vn_pre_ano    holocont.con_preano%TYPE;
BEGIN  -- a??el ejercicio
   -- insert into borra values ('EMILIO','paso1');
-- BUSCA QUE NINGUNO DE LOS CAPITULOS A CANCELAR YA ESTEN PAGADOS O EN PROCESO
   SELECT COUNT(DISTINCT con_keyplz)
     INTO vn_capitulos
     FROM USRSIHO.holocont,USRSIHO.holococa
    WHERE con_keydep = vs_key_dep
      AND con_keyplz = coc_keyplz
      AND coc_keycap BETWEEN vn_ran_ini AND vn_ran_fin
      AND coc_stspag IN ('V','E')
      AND coc_keyrph IS NOT NULL;
   -- insert into borra values ('EMILIO','paso2');

   IF vn_capitulos = 0 THEN   -- SI EXISTEN CAPITULOS PAGADOS O EN PROCESO
      -- RETURN vn_capitulos;
   --ELSE                       -- SI NO EXISTEN CAPITULOS PAGADOS O EN PROCESO DENTRO DEL RANGO
      -- LECTURA DE DATOS

      FOR rec IN (SELECT con_keyplz,con_keydep,con_cosuni,con_keypue,coc_stspag,con_preano
                FROM USRSIHO.holocont,USRSIHO.holococa
               WHERE con_keyplz=coc_keyplz
                 AND con_keydep = vs_key_dep
                 AND con_keytva = 1
                 AND coc_keycap BETWEEN vn_ran_ini AND vn_ran_fin) LOOP
          -- insert into borra values ('EMILIO',vn_cos_uni);

         vn_key_plz := rec.con_keyplz;
         vs_keydep := rec.con_keydep;
         vn_cos_uni := rec.con_cosuni;
         vs_key_pue := rec.con_keypue;
         vs_sts_pag := rec.coc_stspag;
         vn_pre_ano := rec.con_preano;
         vn_rescapi := 0;
         vn_rescapi := (vn_ran_fin - vn_ran_ini) + 1;
         -- POR CADA UNO RESTA EL NUMERO DE CAPITULOS EN HOLOCONT
         UPDATE USRSIHO.holocont
            SET con_numcdi = con_numcdi - vn_rescapi
          WHERE con_keyplz = vn_key_plz
            AND con_keydep = vs_keydep
            AND con_keytva = 1;
         -- insert into borra values ('EMILIO','paso4');
         -- ACTUALIZA EN HOLOCOCA PARA PONER STATUS DE PAGO = CANCELADO
         UPDATE USRSIHO.holococa
             SET coc_stspag = 'C'
          WHERE coc_keyplz = vn_key_plz
            AND coc_keycap BETWEEN vn_ran_ini AND vn_ran_fin
            AND coc_keyrph IS NULL
            AND coc_stspag = 'V';
         -- insert into borra values ('EMILIO','paso5');
         -- POR CADA UNO RESTA AL COSTO UNITARIO EN EL PRESUPUESTO
         IF vs_sts_pag <> 'C' THEN
            BEGIN
                SELECT pre_status
                INTO vpre_status
                FROM USRSIHO.holopres
                WHERE pre_keydep = vs_keydep
                AND pre_keypue = vs_key_pue
                AND pre_anio = vn_pre_ano;
                EXCEPTION WHEN no_data_found THEN vpre_status := '';
            END;               
            IF vpre_status = 'A' THEN
               UPDATE USRSIHO.holopres
                  SET pre_ejerci = pre_ejerci - (vn_cos_uni * vn_rescapi)
                WHERE pre_keydep = vs_keydep
                  AND pre_keypue = vs_key_pue
                  AND pre_anio = vn_pre_ano
                  AND pre_status = 'A';
            ELSE
                BEGIN
                    SELECT MAX(pre_anio)
                      INTO vn_pre_ano
                      FROM USRSIHO.holopres
                    WHERE pre_keydep = vs_keydep
                      AND pre_keypue = vs_key_pue;
                    EXCEPTION WHEN no_data_found THEN vn_pre_ano := 0;
                END;
               UPDATE USRSIHO.holopres
                  SET pre_ejerci = pre_ejerci - (vn_cos_uni * vn_rescapi)
                WHERE pre_keydep = vs_keydep
                  AND pre_keypue = vs_key_pue
                  AND pre_anio = vn_pre_ano;
            END IF;
            -- insert into borra values ('EMILIO','paso6');
         END IF;
      END LOOP;
      -- ACTUALIZA EN HOLOCAPI EL RANGO DE CAPITULOS PARA PONER
      -- EL STATUS DE PAGO = CANCELADO UTILIZANDO PARA ESTO UN AUXILIAR (cap_ca1aux = 'C')
      UPDATE USRSIHO.holocapi
         SET cap_ca1aux = 'C'
       WHERE cap_keydep = vs_key_dep
         AND cap_keycap BETWEEN vn_ran_ini AND vn_ran_fin;
      -- insert into borra values ('EMILIO','paso7');
      -- LLENA LA BITACORA
      vs_cadena := vn_ran_ini || ' AL ' || vn_ran_fin;
      -- insert into borra values ('EMILIO',vs_cadena);
       USRSIHO.sp_bitacora( vn_key_usu,
                                     vs_log_usu,
                                     vs_ide_pcc,
                                     'EL',
                                     'cap_keydep',
                                     'cap_keycap',
                                     ' ',
                                     vs_key_dep,
                                     vs_cadena,
                                     ' ',
                                     'hcaprogr');
      -- Insert into borra values ('EMILIO','FIN');
   END IF;
END;
/
