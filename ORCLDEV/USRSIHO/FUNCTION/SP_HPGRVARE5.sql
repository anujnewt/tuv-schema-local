CREATE OR REPLACE EDITIONABLE FUNCTION "USRSIHO"."SP_HPGRVARE5" (vs_cve_ban  VARCHAR2,
                              vs_sts_fon NUMBER)
RETURN VARCHAR2 IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
  -- Sistema  : RH-2000  C/S
  -- Modulo   : Nomina de Honorarios(ho)
  -- Programa : sp_ hpgrvare2
  --            Definicion de tipo de pago
  -- Autor    : Veronica Vazquez Rodriguez
  -- Fecha    : Noviembre 1999
  -- Modifico : Claudia Torres Rodriguez
-- DEFINE SITUACION
   IF vs_sts_fon = 1 THEN
       RETURN 'EFECTIVO';
   ELSE
     IF (vs_sts_fon = 0 AND vs_cve_ban IS NULL)
       OR (vs_sts_fon = 2) THEN
       RETURN 'CHEQUES';
     ELSE
       IF vs_cve_ban LIKE '002%'
       AND vs_sts_fon = 0 THEN
          RETURN 'BANAMEX';
       ELSE
         IF vs_cve_ban NOT LIKE '002%'
         AND vs_cve_ban IS NOT NULL
         AND vs_sts_fon = 0 THEN
            RETURN 'OTROS BANCOS';
         ELSE
            RETURN 'INDEFINIDO';
         END IF;
       END IF;
     END IF;
   END IF;
END;
/
--Source_DDLS

  CREATE OR REPLACE EDITIONABLE FUNCTION "USRSIHO"."SP_HPGRVARE5" (vs_cve_ban  VARCHAR2,
                              vs_sts_fon NUMBER)
RETURN VARCHAR2 IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
  -- Sistema  : RH-2000  C/S
  -- Modulo   : Nomina de Honorarios(ho)
  -- Programa : sp_ hpgrvare2
  --            Definicion de tipo de pago
  -- Autor    : Veronica Vazquez Rodriguez
  -- Fecha    : Noviembre 1999
  -- Modifico : Claudia Torres Rodriguez
-- DEFINE SITUACION
   IF vs_sts_fon = 1 THEN
       RETURN 'EFECTIVO';
   ELSE
     IF (vs_sts_fon = 0 AND vs_cve_ban IS NULL)
       OR (vs_sts_fon = 2) THEN
       RETURN 'CHEQUES';
     ELSE
       IF vs_cve_ban LIKE '002%'
       AND vs_sts_fon = 0 THEN
          RETURN 'BANAMEX';
       ELSE
         IF vs_cve_ban NOT LIKE '002%'
         AND vs_cve_ban IS NOT NULL
         AND vs_sts_fon = 0 THEN
            RETURN 'OTROS BANCOS';
         ELSE
            RETURN 'INDEFINIDO';
         END IF;
       END IF;
     END IF;
   END IF;
END;
/
