CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_DELIMITED" (ws_campo    VARCHAR2,
                                         ws_delimita VARCHAR2,
                    										 ws_posicion SMALLINT,
										                     vs_valret OUT VARCHAR2)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
vn_nopos    smallint;
vn_largo    smallint;
vn_largo1   smallint;
vn_inicio   integer;
vn_result   VARCHAR2(80);
vn_letras   VARCHAR2(1);
vn_posicion smallint;
vn_subs2    smallint;
vn_subs1    smallint;
vn_cuenta   smallint;
vn_cuenta2  smallint;
vn_cuenta3  smallint;
ws_campo_2  VARCHAR2(20);
BEGIN
   vn_largo    := LENGTH(TRIM(ws_campo));
   vn_subs1    := 1;
   vn_subs2    := 0;
   vn_inicio   := 0;
   vn_result   := '';
   vn_cuenta   := 0;
   vn_posicion := ws_posicion - 1;
   vn_cuenta2  := 0;
   vn_inicio   := vn_largo;
 LOOP
    vn_cuenta2 := vn_cuenta2 + 1;
    vn_letras := trim(SUBSTR(ws_campo, vn_cuenta2, 1));
    IF vn_letras = ws_delimita THEN
        vn_cuenta := vn_cuenta + 1;
        IF vn_cuenta = vn_posicion THEN
            vn_subs1 := vn_cuenta2 + 1;
            EXIT;
        END IF;
    END IF;
    vn_inicio := vn_inicio  + 1;
 END LOOP;
 vn_largo1  := vn_largo - vn_subs1 + 1;
 ws_campo_2 := SUBSTR(ws_campo, vn_subs1, vn_largo1);
 vn_inicio  := 0;
 vn_nopos   := 0;
 vn_cuenta3 := 0;
 vn_inicio := vn_largo1;
 LOOP
    vn_cuenta3 := vn_cuenta3 + 1;
    vn_letras := SUBSTR(ws_campo_2, vn_cuenta3, 1);
    IF vn_letras = '_' THEN
        vs_valret := '0';
        EXIT;
    END IF;
    IF vn_letras = ws_delimita THEN
        vn_nopos := vn_cuenta3- 1;
        vs_valret := SUBSTR(ws_campo_2, 1, vn_nopos);
        EXIT;
     ELSE
        vs_valret := SUBSTR(ws_campo_2, 1, vn_largo1);
     END IF;
     vn_inicio := vn_inicio + 1;
 END LOOP;
END;
/
