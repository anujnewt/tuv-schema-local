CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SP_NMKEYINC" (
	   wn_sem_ila IN NUMBER, ws_key_con IN VARCHAR2, wn_key_pro IN NUMBER,
	   wn_key_nom IN NUMBER, ws_key_per IN VARCHAR2, wn_key_emp IN NUMBER,
	   wn_num_sec IN NUMBER, wn_key_inc OUT NUMBER)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
  wn_lon_cve NUMBER(5);
  i          NUMBER(10);
  ws_cve_con VARCHAR2(9);
  wn_cve_con NUMBER(10);
  ws_cve_pro VARCHAR2(10);
  wn_cve_pro NUMBER(10);
  ws_cve_nom VARCHAR2(10);
  wn_cve_nom NUMBER(10);
  ws_cve_per VARCHAR2(14);
  wn_cve_per NUMBER(10);
  ws_cve_emp VARCHAR2(20);
  wn_cve_emp NUMBER(10);
  wn_cve_tot NUMBER(10);
  wn_lon_ent NUMBER(5);
  ws_sem_ila VARCHAR2(20);
BEGIN
  wn_lon_cve := LENGTH(ws_key_con);
  ws_cve_con := '';
  FOR i IN 1..wn_lon_cve LOOP
    ws_cve_con := ws_cve_con || TO_CHAR(ASCII(SUBSTR(ws_key_con,i,1)));
  END LOOP;
  wn_lon_cve := LENGTH(ws_cve_con);
  wn_cve_con := 0;
  FOR i IN 1..wn_lon_cve LOOP
    wn_cve_con := wn_cve_con + i*TO_NUMBER(SUBSTR(ws_cve_con,wn_lon_cve + 1 - i,1));
  END LOOP;
  ws_cve_pro := TO_CHAR(wn_key_pro);
  wn_lon_cve := LENGTH(ws_cve_pro);
  wn_cve_pro := 0;
  FOR i IN 1..wn_lon_cve LOOP
    wn_cve_pro := wn_cve_pro + i*TO_NUMBER(SUBSTR(ws_cve_pro,wn_lon_cve + 1 - i,1));
  END LOOP;
  ws_cve_nom := TO_CHAR(wn_key_nom);
  wn_lon_cve := LENGTH(ws_cve_nom);
  wn_cve_nom := 0;
  FOR i IN 1..wn_lon_cve LOOP
    wn_cve_nom := wn_cve_nom + i*TO_NUMBER(SUBSTR(ws_cve_nom,wn_lon_cve + 1 - i,1));
  END LOOP;
  ws_cve_per := ws_key_per;
  wn_lon_cve := LENGTH(ws_cve_per);
  wn_cve_per := 0;
  FOR i IN 1..wn_lon_cve LOOP
    wn_cve_per := wn_cve_per + i*TO_NUMBER(SUBSTR(ws_cve_per,wn_lon_cve + 1 - i,1));
  END LOOP;
  ws_cve_emp := TO_CHAR(wn_key_emp);
  wn_lon_cve := LENGTH(ws_cve_emp);
  wn_cve_emp := 0;
  FOR i IN 1..wn_lon_cve LOOP
    wn_cve_emp := wn_cve_emp + i*TO_NUMBER(SUBSTR(ws_cve_emp,wn_lon_cve + 1 - i,1));
  END LOOP;
  ws_sem_ila := TO_CHAR(wn_sem_ila + wn_num_sec);
  wn_cve_tot := wn_cve_emp + TO_NUMBER(TO_CHAR(wn_cve_pro)||TO_CHAR(wn_cve_per)||TO_CHAR(wn_cve_nom)) + wn_cve_con;
  wn_lon_ent := LENGTH(TO_CHAR(FLOOR(TO_NUMBER(TO_CHAR(wn_cve_tot)||ws_sem_ila))));
  IF (wn_lon_ent > 10) THEN
    ws_sem_ila := SUBSTR(ws_sem_ila,wn_lon_ent - 9);
  END IF;
  wn_key_inc := TO_NUMBER(TO_CHAR(wn_cve_tot)||ws_sem_ila);
END;
/
