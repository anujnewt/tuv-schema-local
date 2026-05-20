CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_DECODECHAR" (WS_DATCOM1 IN VARCHAR2,
                                           WS_DATCOM2 IN VARCHAR2,
                                           WS_DATIF   IN VARCHAR2,
                                           WS_DATELSE IN VARCHAR2,
                                           WS_DATSAL OUT VARCHAR2) AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
   IF WS_DATCOM1 = WS_DATCOM2 THEN
      WS_DATSAL := WS_DATIF;
   ELSE
      WS_DATSAL := WS_DATELSE;
   END IF;
END;
/
