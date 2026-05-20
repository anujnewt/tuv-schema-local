create or replace  function  usrsiho."sp_glgetdsl"  (ws_key_tab varchar, ws_key_cam varchar, ws_des_def varchar, wn_lon_max numeric) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
ws_val_etq usrsiho.glcocamp.cam_descam%type := oracle.substr(ws_des_def, 1, 40);
begin
select cam_descam
into strict ws_val_etq
from usrsiho.glcocamp
where cam_keytab = ws_key_tab and
cam_keycam = ws_key_cam;
if nullif(wn_lon_max::text, '') is not null then
return oracle.substr(ws_val_etq, 1, wn_lon_max);
else
return ws_val_etq;
end if;end;
--dmap converted function completed
$body$
language plpgsql
stable;
