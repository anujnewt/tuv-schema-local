CREATE OR REPLACE NONEDITIONABLE FUNCTION "LABCONF"."SP_DELIMITADOR" (ws_campo in varchar2,ws_delimita in varchar2,ws_posicion in smallint) RETURN varchar  IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
 vn_nopos smallint;
 vn_largo smallint;
 vn_largo1 smallint;
 vn_inicio integer;
 vn_result CHAR(80);
 vn_letras CHAR(1);
 vn_posicion smallint;
 vn_subs2 smallint;
 vn_subs1 smallint;
 vn_cuenta smallint;
 vn_cuenta2 smallint;
 vn_cuenta3 smallint;
 ws_campo_aux varchar2(80);
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

  CREATE OR REPLACE NONEDITIONABLE FUNCTION "LABCONF"."SP_DELIMITADOR" (ws_campo in varchar2,ws_delimita in varchar2,ws_posicion in smallint) RETURN varchar  IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
 vn_nopos smallint;
 vn_largo smallint;
 vn_largo1 smallint;
 vn_inicio integer;
 vn_result CHAR(80);
 vn_letras CHAR(1);
 vn_posicion smallint;
 vn_subs2 smallint;
 vn_subs1 smallint;
 vn_cuenta smallint;
 vn_cuenta2 smallint;
 vn_cuenta3 smallint;
 ws_campo_aux varchar2(80);
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
