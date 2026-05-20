create or replace procedure usrsiho."sp_delimited"  (ws_campo varchar, ws_delimita varchar, ws_posicion smallint, vs_valret inout varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
vn_nopos    smallint;
vn_largo    smallint;
vn_largo1   smallint;
vn_inicio   integer;
vn_result   varchar(80);
vn_letras   varchar(1);
vn_posicion smallint;
vn_subs2    smallint;
vn_subs1    smallint;
vn_cuenta   smallint;
vn_cuenta2  smallint;
vn_cuenta3  smallint;
ws_campo_2  varchar(20);
begin
vn_largo    := length(trim(both ws_campo));
vn_subs1    := 1;
vn_subs2    := 0;
vn_inicio   := 0;
vn_result:= null;
vn_cuenta   := 0;
vn_posicion := ws_posicion - 1;
vn_cuenta2  := 0;
vn_inicio   := vn_largo;
loop
vn_cuenta2 := vn_cuenta2 + 1;
vn_letras := trim(both oracle.substr(ws_campo, vn_cuenta2, 1));
if vn_letras = ws_delimita then
vn_cuenta := vn_cuenta + 1;
if vn_cuenta = vn_posicion then
vn_subs1 := vn_cuenta2 + 1;
exit;
end if;
end if;
vn_inicio := vn_inicio  + 1;
end loop;
vn_largo1  := vn_largo - vn_subs1 + 1;
ws_campo_2 := oracle.substr(ws_campo, vn_subs1, vn_largo1);
vn_inicio  := 0;
vn_nopos   := 0;
vn_cuenta3 := 0;
vn_inicio := vn_largo1;
loop
vn_cuenta3 := vn_cuenta3 + 1;
vn_letras := oracle.substr(ws_campo_2, vn_cuenta3, 1);
if vn_letras = '_' then
vs_valret := '0';
exit;
end if;
if vn_letras = ws_delimita then
vn_nopos := vn_cuenta3- 1;
vs_valret := oracle.substr(ws_campo_2, 1, vn_nopos);
exit;
else
vs_valret := oracle.substr(ws_campo_2, 1, vn_largo1);
end if;
vn_inicio := vn_inicio + 1;
end loop;end;
$body$
language plpgsql
;
