CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_HRPINTINC1" (pi_nomina INTEGER, ps_fecha VARCHAR2, ps_area VARCHAR2)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
empleado INTEGER;
depto    VARCHAR2(15);
area     VARCHAR2(4);
BEGIN
-- Actualizamos a Nulos Proceso y Area de los Empleados a Procesar
UPDATE tmp_cont_exclu
   SET con_keypro = null,
       con_arefis = null
 WHERE con_stscon ='A'
   AND con_keynom = pi_nomina
   AND con_fecpag = ps_fecha;
--FOREACH
FOR rec
IN (SELECT con_keyemp, con_keydep
      -- INTO empleado,depto
      FROM tmp_cont_exclu, nmlonomi
     WHERE con_keynom = nom_keynom
       AND con_stscon ='A'
       AND con_keynom = pi_nomina
       AND con_fecpag = ps_fecha)
   LOOP
      empleado := rec.con_keyemp;
      depto    := rec.con_keydep;
      -- Se asigna el Proceso Correspondiente al Empleado
      UPDATE tmp_cont_exclu
         SET con_keypro = (SELECT emp_keypro
                             FROM nmcoempl
                            WHERE emp_keyemp = empleado
                              AND emp_status = 1)
       WHERE con_keyemp = empleado;
       --      -- Se asigna el Area de Ubicaci?orrespondiente al Empleado
       --      UPDATE tmp_cont_exclu
       --         SET con_arefis = (SELECT ale_arefis
       --                             FROM holoalem
       --                            WHERE ale_keyemp = empleado)
       --       WHERE con_keyemp = empleado;
   END LOOP;
--Actualiza el Area Fiscal
-- FOREACH
FOR rec2
IN (SELECT DISTINCT con_keydep
      INTO depto
      FROM tmp_cont_exclu, nmlonomi
     WHERE con_keynom = nom_keynom
       AND con_stscon ='A'
       AND con_keynom = pi_nomina
       AND con_fecpag = ps_fecha)
    LOOP
    depto := rec2.con_keydep;
	BEGIN
		SELECT pam_folfin
		  INTO area
		  FROM glcopams
		 WHERE pam_keypar = (SELECT pam_folini
							   FROM glcopams
							  WHERE pam_keypar = '00'
								AND pam_cvesec = 'pintin')
		   AND pam_nompar = pi_nomina
		   AND pam_folini = depto;
		EXCEPTION WHEN no_data_found THEN area := '';
	END;
   --Si no encuentra valor
   IF area IS NULL THEN
   	--si es la nomina 111, se asigna el area 1 por que el CC no esta parametrizado
     	IF pi_nomina = 111 THEN
         UPDATE tmp_cont_exclu
            SET con_arefis = 1
          WHERE con_stscon ='A'
            AND con_keynom = pi_nomina
            AND con_fecpag = ps_fecha;
      ELSE
         --Si es otra nomina, se asigna el area en la que el usuario esta.
         UPDATE tmp_cont_exclu
            SET con_arefis = ps_area
          WHERE con_stscon ='A'
            AND con_keynom = pi_nomina
            AND con_fecpag = ps_fecha;
      END IF;
   ELSE
      -- Se asigna el Area de Ubicaci?ue esta por Opci
      UPDATE tmp_cont_exclu
         SET con_arefis = area
       WHERE con_stscon ='A'
         AND con_keynom = pi_nomina
         AND con_fecpag = ps_fecha;
   END IF;
END LOOP;
END;
/
