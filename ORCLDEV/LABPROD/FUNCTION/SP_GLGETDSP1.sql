create or replace  function  labprod."sp_glgetdsp1"  (ws_key_tab varchar, ws_key_cam varchar, ws_key_men varchar) returns numeric as $body$
declare
-- pgv moved types start
-- pgv moved types end
ws_dsp_cam varchar(1) := 'S';
wn_val_dsp numeric(5);
begin
select rec_despli
into strict ws_dsp_cam
from glcoreca
where rec_keytab = ws_key_tab and
rec_keycam = ws_key_cam and
rec_keymen = ws_key_men;
if ws_dsp_cam = 'N' then
wn_val_dsp := 1;
else
wn_val_dsp := 0;
end if;
return wn_val_dsp;
exception
when others then
return 0;end;
--dmap converted function completed
$body$
language plpgsql
stable;
