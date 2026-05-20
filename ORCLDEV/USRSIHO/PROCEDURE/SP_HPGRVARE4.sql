CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_HPGRVARE4" (vs_sts_rec SMALLINT,
                                         vs_sts_fon SMALLINT,
                                         vs_cve_ban VARCHAR2,
                                         vn_longi   SMALLINT,
							                           vn_val_ret OUT INTEGER)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
  -- Sistema  : RH-2000  C/S
  -- Modulo   : Nomina de Honorarios(ho)
  -- Programa : sp_ hpgrvare1
  --            Definicion de tipo de pago
  -- Autor    : Veronica Vazquez Rodriguez
  -- Fecha    : 29 de Octubre de 1999
  -- Modifico : Claudia Torres R. 29.Nov.99
  -- Modifico : Emilio Pulido Rangel 25.Mzo.03
  -- En el IF donde retorna 4 vn_longi tenia <16 y le puse <12
BEGIN
-- DEFINE SITUACION
    IF vs_sts_rec = 1 AND vs_sts_fon = 1 THEN
       vn_val_ret := 1;
    ELSIF vs_sts_rec = 1 AND vs_sts_fon IN(0,2) THEN
       vn_val_ret := 2;
    ELSIF  vs_cve_ban = '002' AND vs_sts_rec = 3 AND vs_sts_fon IN(0,3) AND vn_longi = 16 THEN
       vn_val_ret := 3;
    ELSIF  (vs_cve_ban <> '002' AND vs_sts_rec = 3 AND vs_sts_fon = 0)
        OR (vs_cve_ban = '002' AND vs_sts_rec = 3 AND vs_sts_fon IN(0,3) AND vn_longi =18) THEN
       vn_val_ret := 4;
    ELSE
       vn_val_ret := 0;
    END IF;
END;
/
