create or replace  function  usrsiho."sp_glgetrep"  (ws_nom_rep varchar, ws_des_def varchar, wn_lon_max numeric) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
ws_des_lis usrsiho.glcolist.lis_deslis%type := oracle.substr(ws_des_def, 1, 50);
c_deslis record;
begin
for c_deslis in ( select lis_deslis from usrsiho.glcolist
where lis_keylis = ws_nom_rep) loop
ws_des_lis := c_deslis.lis_deslis;
end loop;
if nullif(wn_lon_max::text, '') is not null then
return oracle.substr(ws_des_lis, 1, wn_lon_max);
else
return ws_des_lis;
end if;end;
--dmap converted function completed
$body$
language plpgsql
stable;
