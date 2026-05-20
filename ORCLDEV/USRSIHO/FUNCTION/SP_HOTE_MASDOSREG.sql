CREATE OR REPLACE EDITIONABLE FUNCTION "USRSIHO"."SP_HOTE_MASDOSREG" (PI_NUM_ID NUMBER, PI_KEYEMP NUMBER, PI_SERIAL NUMBER)
RETURN NUMBER IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
-- -----------------------------------------------------------------
-- CREO: 			COMENTARIO:								FECHA:
-- Juan Carlos Reyes Olivera	sp_hote_masdosreg: Este stored procedure se utiliza para saber		29 de Junio de 2011
--				si un actor tiene mas de dos registros con diferente contrato
-- 				esto paea saber si se le debe de calcular el tiempo extra solo
-- 				a un registro y no duplicar el pago de esta oncidencia.
-- 				Devuelve un entero si al registro se debe o no calcular TE
--
-- MODIFICO:			COMENTARIO:								FECHA:
--
--
-- -----------------------------------------------------------------
 LI_NUM_REG NUMBER(10);
 LI_SERIAL NUMBER(10);
 LI_RESULTADO NUMBER(10);
 LI_KEYPUE NUMBER(10);
BEGIN
LI_SERIAL := 0;
LI_NUM_REG := 0;
LI_RESULTADO := 1;
LI_KEYPUE := 0;
SELECT DET_KEYPUE
  INTO LI_KEYPUE
  FROM USRSIHO.HOLODETTRA
 WHERE DET_SERIAL = PI_SERIAL;
SELECT NVL(COUNT(*),1)
  INTO LI_NUM_REG
  FROM USRSIHO.HOLODETTRA, USRSIHO.NMLOALDE
 WHERE DET_KEYDEP = ALD_KEYDEP AND
       DET_NUM_ID = PI_NUM_ID AND
       DET_KEYEMP = PI_KEYEMP AND
       DET_KEYPUE = LI_KEYPUE and
       DET_KEYFOL IS NOT NULL AND
       DET_STSREG = 'V' AND
       DET_INANDA = 'N' AND
       ALD_KEYTPR <> 1;
IF LI_NUM_REG > 1 THEN
    SELECT MIN(DET_SERIAL)
      INTO LI_SERIAL
      FROM USRSIHO.HOLODETTRA
     WHERE DET_NUM_ID = PI_NUM_ID AND
           DET_KEYEMP = PI_KEYEMP AND
           DET_KEYFOL IS NOT NULL AND
           DET_STSREG = 'V' AND
           DET_INANDA = 'N';
    IF LI_SERIAL = PI_SERIAL THEN
        LI_RESULTADO := 1;
    ELSE
         LI_RESULTADO := 0;
    END IF;
END IF;
RETURN LI_RESULTADO;
END;
/
--Source_DDLS

  CREATE OR REPLACE EDITIONABLE FUNCTION "USRSIHO"."SP_HOTE_MASDOSREG" (PI_NUM_ID NUMBER, PI_KEYEMP NUMBER, PI_SERIAL NUMBER)
RETURN NUMBER IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
-- -----------------------------------------------------------------
-- CREO: 			COMENTARIO:								FECHA:
-- Juan Carlos Reyes Olivera	sp_hote_masdosreg: Este stored procedure se utiliza para saber		29 de Junio de 2011
--				si un actor tiene mas de dos registros con diferente contrato
-- 				esto paea saber si se le debe de calcular el tiempo extra solo
-- 				a un registro y no duplicar el pago de esta oncidencia.
-- 				Devuelve un entero si al registro se debe o no calcular TE
--
-- MODIFICO:			COMENTARIO:								FECHA:
--
--
-- -----------------------------------------------------------------
 LI_NUM_REG NUMBER(10);
 LI_SERIAL NUMBER(10);
 LI_RESULTADO NUMBER(10);
 LI_KEYPUE NUMBER(10);
BEGIN
LI_SERIAL := 0;
LI_NUM_REG := 0;
LI_RESULTADO := 1;
LI_KEYPUE := 0;
SELECT DET_KEYPUE
  INTO LI_KEYPUE
  FROM USRSIHO.HOLODETTRA
 WHERE DET_SERIAL = PI_SERIAL;
SELECT NVL(COUNT(*),1)
  INTO LI_NUM_REG
  FROM USRSIHO.HOLODETTRA, USRSIHO.NMLOALDE
 WHERE DET_KEYDEP = ALD_KEYDEP AND
       DET_NUM_ID = PI_NUM_ID AND
       DET_KEYEMP = PI_KEYEMP AND
       DET_KEYPUE = LI_KEYPUE and
       DET_KEYFOL IS NOT NULL AND
       DET_STSREG = 'V' AND
       DET_INANDA = 'N' AND
       ALD_KEYTPR <> 1;
IF LI_NUM_REG > 1 THEN
    SELECT MIN(DET_SERIAL)
      INTO LI_SERIAL
      FROM USRSIHO.HOLODETTRA
     WHERE DET_NUM_ID = PI_NUM_ID AND
           DET_KEYEMP = PI_KEYEMP AND
           DET_KEYFOL IS NOT NULL AND
           DET_STSREG = 'V' AND
           DET_INANDA = 'N';
    IF LI_SERIAL = PI_SERIAL THEN
        LI_RESULTADO := 1;
    ELSE
         LI_RESULTADO := 0;
    END IF;
END IF;
RETURN LI_RESULTADO;
END;
/
