CREATE OR REPLACE EDITIONABLE FUNCTION "USRSIHO"."SP_HPGENLAY" (ws_keynom NUMBER, wn_keypro NUMBER,wn_keyapr NUMBER)
RETURN varchar2 IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
   ws_keycmc varchar2(40);
BEGIN
   SELECT distinct apc_keycmc INTO ws_keycmc FROM USRSIHO.holoapco
    WHERE apc_keynom = ws_keynom
     AND apc_keytfo in ('N', NULL)
     AND apc_keycon NOT IN ('H20','H32','H33','HP8','HP9')
     AND apc_keypro = wn_keypro
     AND apc_keyapr=wn_keyapr;
   RETURN ws_keycmc;
END;
/
--Source_DDLS

  CREATE OR REPLACE EDITIONABLE FUNCTION "USRSIHO"."SP_HPGENLAY" (ws_keynom NUMBER, wn_keypro NUMBER,wn_keyapr NUMBER)
RETURN varchar2 IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
   ws_keycmc varchar2(40);
BEGIN
   SELECT distinct apc_keycmc INTO ws_keycmc FROM USRSIHO.holoapco
    WHERE apc_keynom = ws_keynom
     AND apc_keytfo in ('N', NULL)
     AND apc_keycon NOT IN ('H20','H32','H33','HP8','HP9')
     AND apc_keypro = wn_keypro
     AND apc_keyapr=wn_keyapr;
   RETURN ws_keycmc;
END;
/
