CREATE OR REPLACE EDITIONABLE FUNCTION "LABCONF"."EXENTO_INDEMNIZACION" (wd_fec_ing IN DATE,wd_fec_baj IN DATE, wn_imp_ort IN NUMBER, wn_uma IN NUMBER) RETURN NUMBER IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    wn_tope NUMBER(12,2);
    wn_ani_ser NUMBER(6);
    wn_exento NUMBER(12,2);
  BEGIN
    wn_ani_ser := months_between( wd_fec_baj, wd_fec_ing ) /12;
    wn_tope := 90 * wn_uma * wn_ani_ser;
    IF wn_tope >= wn_imp_ort THEN
      wn_exento := wn_tope;
    ELSE
      wn_exento := wn_imp_ort;
    END IF;
    RETURN wn_exento;
  END;
/
--Source_DDLS

  CREATE OR REPLACE EDITIONABLE FUNCTION "LABCONF"."EXENTO_INDEMNIZACION" (wd_fec_ing IN DATE,wd_fec_baj IN DATE, wn_imp_ort IN NUMBER, wn_uma IN NUMBER) RETURN NUMBER IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    wn_tope NUMBER(12,2);
    wn_ani_ser NUMBER(6);
    wn_exento NUMBER(12,2);
  BEGIN
    wn_ani_ser := months_between( wd_fec_baj, wd_fec_ing ) /12;
    wn_tope := 90 * wn_uma * wn_ani_ser;
    IF wn_tope >= wn_imp_ort THEN
      wn_exento := wn_tope;
    ELSE
      wn_exento := wn_imp_ort;
    END IF;
    RETURN wn_exento;
  END;
/
