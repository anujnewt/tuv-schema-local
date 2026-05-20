CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SV_ALTA_DIA" (
    numero  IN INTEGER,
    dia     IN VARCHAR2,
    medio   IN SMALLINT,
    periodo IN VARCHAR2)
AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
  INSERT
  INTO SVTEMPDIA
    (
      num_emp,
      num_dia,
      is_medio,
      per_vac
    )
    VALUES
    (
      numero,
      to_date(dia,'yyyy/MM/dd'),
      medio,
      periodo
    );
    COMMIT;
END;
/
