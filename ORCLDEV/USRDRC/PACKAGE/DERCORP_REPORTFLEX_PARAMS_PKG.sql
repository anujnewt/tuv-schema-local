CREATE OR REPLACE NONEDITIONABLE PACKAGE "USRDRC"."DERCORP_REPORTFLEX_PARAMS_PKG" 
IS
    --
    --
    --
    PROCEDURE SELECT_PARAMS_PR(
                    idReportFlex IN NUMBER,
                    resultSet OUT SYS_REFCURSOR);
    --
    --
    --
    PROCEDURE INSERT_PARAM_PR(
                    p_ID_REPORTFLEX IN NUMBER,
                    p_ID_PARAM      IN VARCHAR2);
    --
    --
    --
    PROCEDURE UPDATE_PARAM_PR(
                    p_ID_REPORTFLEX IN NUMBER,
                    p_ID_PARAM      IN VARCHAR2,
                    p_PARAM_VALUE   IN VARCHAR2);
    --
    --
    --
    PROCEDURE DELETE_PARAM_PR(
                  p_ID_REPORTFLEX IN NUMBER,
                  p_ID_PARAM      IN VARCHAR2);
END DERCORP_REPORTFLEX_PARAMS_PKG;
/
CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "USRDRC"."DERCORP_REPORTFLEX_PARAMS_PKG" 
IS
  --
  --
  --
  PROCEDURE SELECT_PARAMS_PR(
                  idReportFlex IN NUMBER,
                  resultSet OUT SYS_REFCURSOR)
  IS
  BEGIN
      OPEN resultSet FOR
            SELECT
              ID_PARAM,
              PARAM_VALUE
            FROM
              DERCORP_REPORTFLEX_PARAMS_TAB
            WHERE
              ID_REPORTFLEX = idReportFlex;
  END SELECT_PARAMS_PR;
  --
  --
  --
  PROCEDURE INSERT_PARAM_PR(
                  p_ID_REPORTFLEX         IN NUMBER,
                  p_ID_PARAM              IN VARCHAR2)
  IS
  BEGIN
        INSERT INTO DERCORP_REPORTFLEX_PARAMS_TAB
          (
            ID_REPORTFLEX ,
            ID_PARAM
          )
          VALUES
          (
             p_ID_REPORTFLEX,
              p_ID_PARAM
          );
  END INSERT_PARAM_PR;
  --
  --
  --
  PROCEDURE UPDATE_PARAM_PR(
                    p_ID_REPORTFLEX         IN NUMBER,
                    p_ID_PARAM              IN VARCHAR2,
                    p_PARAM_VALUE           IN VARCHAR2)
  IS
  BEGIN
        UPDATE DERCORP_REPORTFLEX_PARAMS_TAB SET
          PARAM_VALUE           = p_PARAM_VALUE
        WHERE ID_REPORTFLEX     = p_ID_REPORTFLEX
        AND ID_PARAM            = p_ID_PARAM;
  END UPDATE_PARAM_PR;
  --
  --
  --
  PROCEDURE DELETE_PARAM_PR(
                  p_ID_REPORTFLEX         IN NUMBER,
                  p_ID_PARAM              IN VARCHAR2)
  IS
  BEGIN
        DELETE FROM
            DERCORP_REPORTFLEX_PARAMS_TAB
        WHERE
          ID_REPORTFLEX = p_ID_REPORTFLEX
          AND
          ID_PARAM        = p_ID_PARAM;
  END DELETE_PARAM_PR;
END DERCORP_REPORTFLEX_PARAMS_PKG;
/;
