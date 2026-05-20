CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SV_USERRED" (
    NUM_EMPLEADO IN NUMBER ,
    USU_RED      IN VARCHAR2 ,
    FECHA_S      IN VARCHAR2 )
AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
  INSERT
  INTO userred
    (
      NUM_EMP,
      EMP_KEYRED,
      FEC_SOL
    )
    VALUES
    (
      NUM_EMPLEADO,
      USU_RED,
      FECHA_S
    );
END;
/
