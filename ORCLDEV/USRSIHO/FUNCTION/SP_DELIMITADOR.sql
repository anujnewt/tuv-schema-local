create or replace  function  usrsiho."sp_delimitador"  (ws_campo varchar,ws_delimita varchar,ws_posicion numeric) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
vn_nopos numeric(5);
vn_largo numeric(5);
vn_largo1 numeric(5);
vn_inicio numeric(10);
vn_result varchar(80);
vn_letras varchar(1);
vn_posicion numeric(5);
vn_subs2 numeric(5);
vn_subs1 numeric(5);
vn_cuenta numeric(5);
vn_cuenta2 numeric(5);
vn_cuenta3 numeric(5);
ws_campo_sig varchar(100);
begin
vn_largo  := length(trim(both ws_campo));
vn_subs1 := 1;
vn_subs2 := 0;
vn_inicio := 0;
vn_result:= null;
vn_cuenta := 0;
vn_posicion := ws_posicion - 1;
vn_cuenta2 := 0;
for  vn_inicio in  1 .. vn_largo  loop
vn_cuenta2 := vn_cuenta2 + 1;
vn_letras := trim(both oracle.substr(ws_campo,vn_cuenta2,1));
if vn_letras = ws_delimita
then
vn_cuenta := vn_cuenta + 1;
if vn_cuenta = vn_posicion then
vn_subs1 := vn_cuenta2+ 1;
exit;
end if;
end if;
end loop;
vn_largo1 := vn_largo - vn_subs1 + 1;
ws_campo_sig  := oracle.substr(ws_campo,vn_subs1,vn_largo1);
vn_inicio := 0;
vn_nopos := 0;
vn_cuenta3 := 0;
for vn_inicio in 1 .. vn_largo1 loop
vn_cuenta3 := vn_cuenta3 + 1;
vn_letras := oracle.substr(ws_campo_sig,vn_cuenta3,1);
if vn_letras = ws_delimita then
vn_nopos := vn_cuenta3- 1;
vn_result := oracle.substr(ws_campo_sig,1,vn_nopos);
exit;
else
vn_result := oracle.substr(ws_campo_sig,1,vn_largo1);
end if;
end loop;
return vn_result;end;
--dmap converted function completed
$body$
language plpgsql
stable;
