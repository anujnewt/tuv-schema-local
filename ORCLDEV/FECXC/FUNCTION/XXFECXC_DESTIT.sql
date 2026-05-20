CREATE OR REPLACE EDITIONABLE FUNCTION "FECXC"."XXFECXC_DESTIT" (pinTipo  IN  PLS_INTEGER)
RETURN VARCHAR2
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    lstDesTitulo    FECXC.XXFECXC_TIT_REP_COMER_TAB.DES_TITULO%TYPE;
BEGIN
    -- pinTipo = 0      Titulo
    -- pinTipo = 1      Subtitulo
    IF pinTipo = 0
    THEN
        SELECT    DES_TITULO
          INTO    lstDesTitulo
          FROM    XXFECXC_TIT_REP_COMER_TAB
         WHERE    IND_ELIJE_TITULO = 1
              AND IND_TITULO_ACTIVO = 1;
    ELSE
        SELECT    DES_TITULO
          INTO    lstDesTitulo
          FROM    XXFECXC_TIT_REP_COMER_TAB
         WHERE    IND_ELIJE_TITULO = 2
              AND IND_TITULO_ACTIVO = 1;
    END IF;
    RETURN lstDesTitulo;
END;
/
--Source_DDLS

  CREATE OR REPLACE EDITIONABLE FUNCTION "FECXC"."XXFECXC_DESTIT" (pinTipo  IN  PLS_INTEGER)
RETURN VARCHAR2
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    lstDesTitulo    FECXC.XXFECXC_TIT_REP_COMER_TAB.DES_TITULO%TYPE;
BEGIN
    -- pinTipo = 0      Titulo
    -- pinTipo = 1      Subtitulo
    IF pinTipo = 0
    THEN
        SELECT    DES_TITULO
          INTO    lstDesTitulo
          FROM    XXFECXC_TIT_REP_COMER_TAB
         WHERE    IND_ELIJE_TITULO = 1
              AND IND_TITULO_ACTIVO = 1;
    ELSE
        SELECT    DES_TITULO
          INTO    lstDesTitulo
          FROM    XXFECXC_TIT_REP_COMER_TAB
         WHERE    IND_ELIJE_TITULO = 2
              AND IND_TITULO_ACTIVO = 1;
    END IF;
    RETURN lstDesTitulo;
END;
/
