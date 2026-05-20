CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SP_VAC_INSERTARSOL" 
(
  KEYEMP IN NUMBER,
  KEYCON IN VARCHAR2,
  FECINI IN DATE,
  FECFIN IN DATE,
  NUMDIA IN NUMBER,
  STATUS IN NUMBER,
  EMPAUT IN NUMBER,
  KEYUSU IN NUMBER,
  KEYMOT IN VARCHAR2,
  OBSERV IN VARCHAR2,
  NUMANI IN NUMBER,
  FECPER IN DATE,
  KEYSOL OUT NUMBER
) AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
KEYPRO SMALLINT;
BEGIN
  SELECT EMP_KEYPRO INTO KEYPRO
  FROM LABPROD.NMCOEMPL
  WHERE EMP_KEYEMP = KEYEMP;
  INSERT INTO LABPROD.molosoli
         (sol_keyemp,sol_keycon,sol_fecini,sol_fecfin,sol_numdia,sol_status,sol_empaut,sol_keyusu,sol_keymot,sol_observ,sol_fecmod,sol_hormod,
          sol_keypro,sol_numani,sol_fecper)
  VALUES (KEYEMP    ,KEYCON    ,FECINI    ,FECFIN    ,NUMDIA    ,STATUS    ,EMPAUT    ,KEYUSU    ,KEYMOT    ,OBSERV    ,SYSDATE   ,TO_CHAR (SYSDATE, 'HH24:MI:SS'),
          KEYPRO    ,NUMANI    ,FECPER)
  RETURNING sol_keysol INTO KEYSOL;
  COMMIT;
END SP_VAC_INSERTARSOL;
/
