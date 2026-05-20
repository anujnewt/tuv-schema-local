CREATE OR REPLACE EDITIONABLE FUNCTION "USRSIHO"."SP_DELIMITADOR" (ws_campo IN VARCHAR2,ws_delimita IN VARCHAR2,ws_posicion IN number)
RETURN VARCHAR2
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
 vn_nopos number(5);
 vn_largo number(5);
 vn_largo1 number(5);
 vn_inicio number(10);
 vn_result VARCHAR2(80);
 vn_letras VARCHAR2(1);
 vn_posicion number(5);
 vn_subs2 number(5);
 vn_subs1 number(5);
 vn_cuenta number(5);
 vn_cuenta2 number(5);
 vn_cuenta3 number(5);
  ws_campo_sig VARCHAR2(100);
BEGIN
vn_largo  := length(trim(ws_campo));
vn_subs1 := 1;
vn_subs2 := 0;
vn_inicio := 0;
vn_result := '';
vn_cuenta := 0;
vn_posicion := ws_posicion - 1;
vn_cuenta2 := 0;
 FOR  vn_inicio in  1 .. vn_largo  LOOP
   vn_cuenta2 := vn_cuenta2 + 1;
   vn_letras := trim(substr(ws_campo,vn_cuenta2,1));
      IF vn_letras = ws_delimita
        THEN
           vn_cuenta := vn_cuenta + 1;
           IF vn_cuenta = vn_posicion THEN
             vn_subs1 := vn_cuenta2+ 1;
            EXIT;
         END IF;
      END IF;
END LOOP;
vn_largo1 := vn_largo - vn_subs1 + 1;
ws_campo_sig  := substr(ws_campo,vn_subs1,vn_largo1);
vn_inicio := 0;
vn_nopos := 0;
vn_cuenta3 := 0;
 FOR vn_inicio IN 1 .. vn_largo1 LOOP
   vn_cuenta3 := vn_cuenta3 + 1;
      vn_letras := substr(ws_campo_sig,vn_cuenta3,1);
     IF vn_letras = ws_delimita THEN
       vn_nopos := vn_cuenta3- 1;
       vn_result := substr(ws_campo_sig,1,vn_nopos);
       EXIT;
     ELSE
       vn_result := substr(ws_campo_sig,1,vn_largo1);
    END IF;
 END LOOP;
RETURN vn_result;
END;
/
--Source_DDLS

  CREATE OR REPLACE EDITIONABLE FUNCTION "USRSIHO"."SP_DELIMITADOR" (ws_campo IN VARCHAR2,ws_delimita IN VARCHAR2,ws_posicion IN number)
RETURN VARCHAR2
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
 vn_nopos number(5);
 vn_largo number(5);
 vn_largo1 number(5);
 vn_inicio number(10);
 vn_result VARCHAR2(80);
 vn_letras VARCHAR2(1);
 vn_posicion number(5);
 vn_subs2 number(5);
 vn_subs1 number(5);
 vn_cuenta number(5);
 vn_cuenta2 number(5);
 vn_cuenta3 number(5);
  ws_campo_sig VARCHAR2(100);
BEGIN
vn_largo  := length(trim(ws_campo));
vn_subs1 := 1;
vn_subs2 := 0;
vn_inicio := 0;
vn_result := '';
vn_cuenta := 0;
vn_posicion := ws_posicion - 1;
vn_cuenta2 := 0;
 FOR  vn_inicio in  1 .. vn_largo  LOOP
   vn_cuenta2 := vn_cuenta2 + 1;
   vn_letras := trim(substr(ws_campo,vn_cuenta2,1));
      IF vn_letras = ws_delimita
        THEN
           vn_cuenta := vn_cuenta + 1;
           IF vn_cuenta = vn_posicion THEN
             vn_subs1 := vn_cuenta2+ 1;
            EXIT;
         END IF;
      END IF;
END LOOP;
vn_largo1 := vn_largo - vn_subs1 + 1;
ws_campo_sig  := substr(ws_campo,vn_subs1,vn_largo1);
vn_inicio := 0;
vn_nopos := 0;
vn_cuenta3 := 0;
 FOR vn_inicio IN 1 .. vn_largo1 LOOP
   vn_cuenta3 := vn_cuenta3 + 1;
      vn_letras := substr(ws_campo_sig,vn_cuenta3,1);
     IF vn_letras = ws_delimita THEN
       vn_nopos := vn_cuenta3- 1;
       vn_result := substr(ws_campo_sig,1,vn_nopos);
       EXIT;
     ELSE
       vn_result := substr(ws_campo_sig,1,vn_largo1);
    END IF;
 END LOOP;
RETURN vn_result;
END;
/
