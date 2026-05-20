CREATE OR REPLACE NONEDITIONABLE FUNCTION "USRDRC"."DENOM_ANTERIORES_FN" (pistEmpresa NUMBER) RETURN VARCHAR2 IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
lstDenimonaciones VARCHAR2(11200);
/******************************************************************************
   NAME:       denom_anteriores_fn
   PURPOSE:
   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        14/07/2015   Jesus Argumedo       1. Created this function.
******************************************************************************/
BEGIN
   FOR denom IN  (SELECT val_c1
       FROM dercorp_metatbl_tab
       WHERE id_flex_tbl = 2
       AND   id_empresa  = pistEmpresa)
   LOOP
        lstDenimonaciones := lstDenimonaciones || denom.val_c1 || '|';
   END LOOP;
   RETURN lstDenimonaciones;
   EXCEPTION
     WHEN NO_DATA_FOUND THEN
      lstDenimonaciones := SQLERRM;
     WHEN OTHERS THEN
       lstDenimonaciones := SQLERRM;
END denom_anteriores_fn;
/
--Source_DDLS

  CREATE OR REPLACE NONEDITIONABLE FUNCTION "USRDRC"."DENOM_ANTERIORES_FN" (pistEmpresa NUMBER) RETURN VARCHAR2 IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
lstDenimonaciones VARCHAR2(11200);
/******************************************************************************
   NAME:       denom_anteriores_fn
   PURPOSE:
   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        14/07/2015   Jesus Argumedo       1. Created this function.
******************************************************************************/
BEGIN
   FOR denom IN  (SELECT val_c1
       FROM dercorp_metatbl_tab
       WHERE id_flex_tbl = 2
       AND   id_empresa  = pistEmpresa)
   LOOP
        lstDenimonaciones := lstDenimonaciones || denom.val_c1 || '|';
   END LOOP;
   RETURN lstDenimonaciones;
   EXCEPTION
     WHEN NO_DATA_FOUND THEN
      lstDenimonaciones := SQLERRM;
     WHEN OTHERS THEN
       lstDenimonaciones := SQLERRM;
END denom_anteriores_fn;
/
