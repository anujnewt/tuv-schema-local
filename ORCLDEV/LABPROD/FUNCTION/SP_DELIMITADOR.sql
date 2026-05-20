CREATE OR REPLACE NONEDITIONABLE FUNCTION "LABPROD"."SP_DELIMITADOR" (ws_campo in varchar2,ws_delimita in varchar2,ws_posicion in integer) RETURN varchar  IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
 vn_nopos integer;
 vn_largo integer;
 vn_largo1 integer;
 vn_inicio integer;
 vn_result CHAR(180);
 vn_letras CHAR(1);
 vn_posicion integer;
 vn_subs2 integer;
 vn_subs1 integer;
 vn_cuenta integer;
 vn_cuenta2 integer;
 vn_cuenta3 integer;
 ws_campo_aux varchar2(180);
BEGIN
 vn_largo := length(trim(ws_campo));
 vn_subs1 := 1;
 vn_subs2 := 0;
 vn_inicio := 0;
 vn_result := ' ';
 vn_cuenta := 0;
 vn_posicion := ws_posicion - 1;
 vn_cuenta2 := 0;
---------------------------------
FOR  vn_inicio in 0 .. vn_largo
LOOP
    vn_cuenta2 := vn_cuenta2 + 1;
    vn_letras := rtrim(substr(ws_campo,vn_cuenta2,1));
      IF vn_letras = ws_delimita THEN
            vn_cuenta := vn_cuenta + 1;
           IF vn_cuenta = vn_posicion THEN
              vn_subs1 := vn_cuenta2+ 1;
           END IF;
           EXIT when vn_cuenta = vn_posicion;
      END IF;
END LOOP;
-------------------------------------
 vn_largo1 := vn_largo - vn_subs1 + 1;
 ws_campo_aux  := substr(ws_campo,vn_subs1,vn_largo1);
 vn_inicio := 0;
 vn_nopos := 0;
 vn_cuenta3 := 0;
---------------------------------------
 FOR vn_inicio in 0 .. vn_largo1
 LOOP
    vn_cuenta3 := vn_cuenta3 + 1;
    vn_letras := substr(ws_campo_aux,vn_cuenta3,1);
     IF vn_letras = ws_delimita THEN
        vn_nopos := vn_cuenta3- 1;
        vn_result := substr(ws_campo_aux,1,vn_nopos);
      ELSE
        vn_result := substr(ws_campo_aux,1,vn_largo1);
     END IF;
    exit when vn_letras = ws_delimita;
 END LOOP;
 --------------------------------------
RETURN vn_result;
END;
/
--Source_DDLS

  CREATE OR REPLACE NONEDITIONABLE FUNCTION "LABPROD"."SP_DELIMITADOR" (ws_campo in varchar2,ws_delimita in varchar2,ws_posicion in integer) RETURN varchar  IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
 vn_nopos integer;
 vn_largo integer;
 vn_largo1 integer;
 vn_inicio integer;
 vn_result CHAR(180);
 vn_letras CHAR(1);
 vn_posicion integer;
 vn_subs2 integer;
 vn_subs1 integer;
 vn_cuenta integer;
 vn_cuenta2 integer;
 vn_cuenta3 integer;
 ws_campo_aux varchar2(180);
BEGIN
 vn_largo := length(trim(ws_campo));
 vn_subs1 := 1;
 vn_subs2 := 0;
 vn_inicio := 0;
 vn_result := ' ';
 vn_cuenta := 0;
 vn_posicion := ws_posicion - 1;
 vn_cuenta2 := 0;
---------------------------------
FOR  vn_inicio in 0 .. vn_largo
LOOP
    vn_cuenta2 := vn_cuenta2 + 1;
    vn_letras := rtrim(substr(ws_campo,vn_cuenta2,1));
      IF vn_letras = ws_delimita THEN
            vn_cuenta := vn_cuenta + 1;
           IF vn_cuenta = vn_posicion THEN
              vn_subs1 := vn_cuenta2+ 1;
           END IF;
           EXIT when vn_cuenta = vn_posicion;
      END IF;
END LOOP;
-------------------------------------
 vn_largo1 := vn_largo - vn_subs1 + 1;
 ws_campo_aux  := substr(ws_campo,vn_subs1,vn_largo1);
 vn_inicio := 0;
 vn_nopos := 0;
 vn_cuenta3 := 0;
---------------------------------------
 FOR vn_inicio in 0 .. vn_largo1
 LOOP
    vn_cuenta3 := vn_cuenta3 + 1;
    vn_letras := substr(ws_campo_aux,vn_cuenta3,1);
     IF vn_letras = ws_delimita THEN
        vn_nopos := vn_cuenta3- 1;
        vn_result := substr(ws_campo_aux,1,vn_nopos);
      ELSE
        vn_result := substr(ws_campo_aux,1,vn_largo1);
     END IF;
    exit when vn_letras = ws_delimita;
 END LOOP;
 --------------------------------------
RETURN vn_result;
END;
/
