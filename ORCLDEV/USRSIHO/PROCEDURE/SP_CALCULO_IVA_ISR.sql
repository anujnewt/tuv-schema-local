CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_CALCULO_IVA_ISR" (wn_key_pro IN NUMBER,wn_key_nom IN NUMBER, ws_key_per IN varchar, ws_key_con IN varchar, wn_por_cen IN number, ws_con_bas IN VARCHAR, ws_cod_imp IN VARCHAR)
AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
wn_tot_bas number(16,2);  --Suma del importe del concepto base
wn_tot_imp number(16,2);  --Suma del importe del concepto de impuesto
wn_imp_ort number(16,2);  --C??lculo del impuesto a partir del total de la base
wn_dif number(16,2);   --Diferencia entre el impuesta calculado y la suma del importe del concepto de impuesto.
wn_num_emp number(8); --N??mero de empleados a los que se les hara ajuste de 1 centavo
wn_aju_imp number(16,2);  --Importe del ajuste
BEGIN
  /*Realiza el c??lculo de IVA e ISR realizando un ajuste por empleado de tal forma que la sumatoria de IVA e ISR por empleado
    sea igual que el c??lculo de IVA e ISR realizado con el total de la base */
  --Obtener la suma del importe del concepto base
  SELECT SUM(mov_import) INTO wn_tot_bas
  FROM USRSIHO.nmwkmovt
  WHERE mov_keypro = wn_key_pro
    AND mov_keyper = ws_key_per
    AND mov_keynom = wn_key_nom
    AND mov_keycon = ws_con_bas;
  --Obtener la suma del impirte del concepto de impuesto
  SELECT SUM(mov_import) INTO wn_tot_imp
  FROM USRSIHO.nmwkmovt
  WHERE mov_keypro = wn_key_pro
    AND mov_keyper = ws_key_per
    AND mov_keynom = wn_key_nom
    AND mov_keycon = ws_key_con;
  wn_imp_ort := wn_tot_bas * wn_por_cen / 100;   --Calculo del impuesto a partir de la suma del importe del concepto base
  wn_dif := wn_tot_imp - wn_imp_ort;  --Diferencia entre el impuesto c??lculado y la suma del importe del concepto de impuesto
  wn_num_emp := ABS(wn_dif * 100);   --N??mero de empleados con ajuste
  IF wn_dif = 0 THEN
    RETURN;
  END IF;
  IF wn_dif < 0 THEN
    wn_aju_imp := 0.01;
  ELSE
    wn_aju_imp := -0.01;
  END IF;
  INSERT INTO USRSIHO.TMP_EMPLEADOS
  SELECT mov_keyemp
    FROM USRSIHO.nmwkmovt
    WHERE mov_keypro = wn_key_pro
      AND mov_keyper = ws_key_per
      AND mov_keynom = wn_key_nom
      AND mov_keycon = ws_key_con
      AND rownum <= wn_num_emp;
  --Realizar el ajuste
  UPDATE USRSIHO.nmwkmovt SET mov_import = mov_import + wn_aju_imp
  WHERE mov_keypro = wn_key_pro
    AND mov_keyper = ws_key_per
    AND mov_keynom = wn_key_nom
    AND mov_keycon = ws_key_con
    AND mov_keyemp IN (SELECT keyemp FROM USRSIHO.TMP_EMPLEADOS);
  IF ws_cod_imp = '01' THEN
    UPDATE USRSIHO.nmwkmovt SET mov_import = mov_import + wn_aju_imp
    WHERE mov_keypro = wn_key_pro
      AND mov_keyper = ws_key_per
      AND mov_keynom = wn_key_nom
      AND mov_keycon IN ('HTP','HPN')
      AND mov_keyemp IN (SELECT keyemp FROM USRSIHO.TMP_EMPLEADOS);
  ELSE
    UPDATE USRSIHO.nmwkmovt SET mov_import = mov_import + wn_aju_imp
    WHERE mov_keypro = wn_key_pro
      AND mov_keyper = ws_key_per
      AND mov_keynom = wn_key_nom
      AND mov_keycon IN ('HTD')
      AND mov_keyemp IN (SELECT keyemp FROM USRSIHO.TMP_EMPLEADOS);
    UPDATE USRSIHO.nmwkmovt SET mov_import = mov_import - wn_aju_imp
    WHERE mov_keypro = wn_key_pro
      AND mov_keyper = ws_key_per
      AND mov_keynom = wn_key_nom
      AND mov_keycon IN ('HPN')
      AND mov_keyemp IN (SELECT keyemp FROM USRSIHO.TMP_EMPLEADOS);
    IF ws_key_con = 'H24' THEN
      UPDATE USRSIHO.nmwkmovt SET mov_import = mov_import + wn_aju_imp
      WHERE mov_keypro = wn_key_pro
        AND mov_keyper = ws_key_per
        AND mov_keynom = wn_key_nom
        AND mov_keycon IN ('H59')
        AND mov_keyemp IN (SELECT keyemp FROM USRSIHO.TMP_EMPLEADOS);
    END IF;
  END IF;
  COMMIT;
END;
/
