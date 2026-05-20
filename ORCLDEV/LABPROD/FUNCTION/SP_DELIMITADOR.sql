create or replace  function  labprod."sp_delimitador"  (ws_campo varchar,ws_delimita varchar,ws_posicion integer) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
vn_nopos integer;
vn_largo integer;
vn_largo1 integer;
vn_inicio integer;
vn_result char(180);
vn_letras char(1);
vn_posicion integer;
vn_subs2 integer;
vn_subs1 integer;
vn_cuenta integer;
vn_cuenta2 integer;
vn_cuenta3 integer;
ws_campo_aux varchar(180);
begin
vn_largo := length(trim(both ws_campo));
vn_subs1 := 1;
vn_subs2 := 0;
vn_inicio := 0;
vn_result := ' ';
vn_cuenta := 0;
vn_posicion := ws_posicion - 1;
vn_cuenta2 := 0;
---------------------------------
for  vn_inicio in 0 .. vn_largo
loop
vn_cuenta2 := vn_cuenta2 + 1;/* dmap converted statement start */
vn_letras := rtrim(oracle.substr(ws_campo::text,vn_cuenta2,1));/* dmap converted statement end */
if vn_letras = ws_delimita then
vn_cuenta := vn_cuenta + 1;
if vn_cuenta = vn_posicion then
vn_subs1 := vn_cuenta2+ 1;
end if;
exit when vn_cuenta = vn_posicion;
end if;
end loop;
-------------------------------------
vn_largo1 := vn_largo - vn_subs1 + 1;
ws_campo_aux  := oracle.substr(ws_campo,vn_subs1,vn_largo1);
vn_inicio := 0;
vn_nopos := 0;
vn_cuenta3 := 0;
---------------------------------------
for vn_inicio in 0 .. vn_largo1
loop
vn_cuenta3 := vn_cuenta3 + 1;
vn_letras := oracle.substr(ws_campo_aux,vn_cuenta3,1);
if vn_letras = ws_delimita then
vn_nopos := vn_cuenta3- 1;
vn_result := oracle.substr(ws_campo_aux,1,vn_nopos);
else
vn_result := oracle.substr(ws_campo_aux,1,vn_largo1);
end if;
exit when vn_letras = ws_delimita;
end loop;
--------------------------------------
return vn_result;end;
--dmap converted function completed
$body$
language plpgsql
stable;
