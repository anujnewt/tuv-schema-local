CREATE OR REPLACE NONEDITIONABLE FUNCTION "LABPROD"."FN_NUEVOPERIODO" (wn_pro_nue IN NUMBER, wn_pro_ori IN NUMBER, ws_per_ori IN VARCHAR2)
RETURN VARCHAR2 IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    -- BUSCA EL PERIOD EQUIVALENTE PARA EL PROCESO NUEVO EN UNA TRANSFERENCIA SIN CAMBIO DE N??MERO DE EMPLEADO
  ws_per_nue VARCHAR2(7);
  wd_fec_pag DATE;
BEGIN
  BEGIN
    SELECT PER_FECPAG INTO wd_fec_pag
    FROM LABPROD.nmloperi
    WHERE per_keypro = wn_pro_ori
      AND per_keyper = ws_per_ori;
    EXCEPTION WHEN NO_DATA_FOUND THEN
    RETURN ws_per_ori;
  END;
  SELECT per_keyper INTO ws_per_nue
  FROM LABPROD.nmloperi
  WHERE per_keypro = wn_pro_nue
    AND per_keynom = 1
    AND per_fecini <= wd_fec_pag
    AND per_fecfin >= wd_fec_pag;
	RETURN ws_per_nue;
  EXCEPTION WHEN OTHERS THEN
    RETURN ws_per_ori;
END;
/
--Source_DDLS

  CREATE OR REPLACE NONEDITIONABLE FUNCTION "LABPROD"."FN_NUEVOPERIODO" (wn_pro_nue IN NUMBER, wn_pro_ori IN NUMBER, ws_per_ori IN VARCHAR2)
RETURN VARCHAR2 IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    -- BUSCA EL PERIOD EQUIVALENTE PARA EL PROCESO NUEVO EN UNA TRANSFERENCIA SIN CAMBIO DE N??MERO DE EMPLEADO
  ws_per_nue VARCHAR2(7);
  wd_fec_pag DATE;
BEGIN
  BEGIN
    SELECT PER_FECPAG INTO wd_fec_pag
    FROM LABPROD.nmloperi
    WHERE per_keypro = wn_pro_ori
      AND per_keyper = ws_per_ori;
    EXCEPTION WHEN NO_DATA_FOUND THEN
    RETURN ws_per_ori;
  END;
  SELECT per_keyper INTO ws_per_nue
  FROM LABPROD.nmloperi
  WHERE per_keypro = wn_pro_nue
    AND per_keynom = 1
    AND per_fecini <= wd_fec_pag
    AND per_fecfin >= wd_fec_pag;
	RETURN ws_per_nue;
  EXCEPTION WHEN OTHERS THEN
    RETURN ws_per_ori;
END;
/
