CREATE OR REPLACE EDITIONABLE PROCEDURE "FECI"."HISTFECI_PROCESA_CONCEPTO_REGION_PR" AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
  v_id_concepto FECI_CONCEPTO_CAT.ID_CONCEPTO%TYPE;
  v_id_region FECI_REGION_CAT.ID_REGION%TYPE;
  CONTADOR NUMBER;
BEGIN
  FOR rec IN (SELECT COD_CONCEPTO, DES_CONCEPTO, COD_REGION, DES_REGION
              FROM HISTFECI_RECIBOS_MASIVO_TAB)
  LOOP
    BEGIN
        IF rec.COD_CONCEPTO IS NULL THEN
            v_id_concepto := 0;
        ELSE
            -- Verificar si el concepto ya existe
            SELECT NVL(ID_CONCEPTO, NULL) INTO v_id_concepto
            FROM FECI_CONCEPTO_CAT
            WHERE COD_CONCEPTO = TRIM(rec.COD_CONCEPTO);
        END IF;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            v_id_concepto := NULL; -- Asigna un valor nulo cuando no se encuentra ninguna fila
    END;
    IF v_id_concepto IS NULL THEN
      -- Insertar el concepto si no existe
      INSERT INTO FECI_CONCEPTO_CAT (COD_CONCEPTO, DES_CONCEPTO,FEC_CREACION,FEC_ULT_MODIFICACION,ID_USUARIO_CREACION,
      ID_USUARIO_ULT_MODIF,IND_ESTADO)
      VALUES (rec.COD_CONCEPTO, rec.DES_CONCEPTO,SYSDATE,SYSDATE,0,0,1);
      -- Obtener el ID del concepto recien insertado
      SELECT ID_CONCEPTO INTO v_id_concepto
      FROM FECI_CONCEPTO_CAT
      WHERE COD_CONCEPTO = rec.COD_CONCEPTO;
    END IF;
    -- Verificar si la region ya existe
    BEGIN
        IF rec.COD_REGION IS NULL THEN
            v_id_region := 0;
        ELSE
            SELECT NVL(ID_REGION, NULL) INTO v_id_region
            FROM FECI_REGION_CAT
            WHERE COD_REGION = TRIM(rec.COD_REGION);
        END IF;
    EXCEPTION
         WHEN NO_DATA_FOUND THEN
            v_id_region := NULL; -- Asigna un valor nulo cuando no se encuentra ninguna fila
    END;
    IF v_id_region IS NULL THEN
      -- Insertar la region si no existe
      INSERT INTO FECI_REGION_CAT (COD_REGION, DES_REGION,FEC_CREACION,FEC_ULT_MODIFICACION,ID_USUARIO_CREACION,
      ID_USUARIO_ULT_MODIF,IND_ESTADO)
      VALUES (rec.COD_REGION, rec.DES_REGION,SYSDATE,SYSDATE,0,0,1);
      -- Obtener el ID de la region recien insertada
      SELECT ID_REGION INTO v_id_region
      FROM FECI_REGION_CAT
      WHERE COD_REGION = rec.COD_REGION;
    END IF;
    IF v_id_concepto >0 AND v_id_region> 0 THEN
        SELECT COUNT(*) INTO CONTADOR FROM FECI_REGN_CONC_CAT
        WHERE ID_CONCEPTO = v_id_concepto AND ID_REGION = v_id_region;
        -- Verificar si el registro ya existe en FECI_REGN_CONC_CAT
        IF CONTADOR=0 THEN
           -- Insertar el registro en FECI_REGN_CONC_CAT si no existe
            INSERT INTO FECI_REGN_CONC_CAT (ID_CONCEPTO, ID_REGION,FEC_CREACION,FEC_ULT_MODIFICACION,ID_USUARIO_CREACION,
            ID_USUARIO_ULT_MODIF,IND_ESTADO)
            VALUES (v_id_concepto, v_id_region,SYSDATE,SYSDATE,0,0,1);
        END IF;
    END IF;
  END LOOP;
END;
/
