create or replace procedure labprod."sp_glnewdsp"  (ws_key_tab varchar,ws_key_cam varchar,ws_key_men varchar,wn_val_dsp inout numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
ws_dsp_cam varchar(1);
cur01 record;
begin
wn_val_dsp:=0;
for cur01 in ( select rec_despli from glcoreca
where rec_keytab=ws_key_tab
and rec_keycam=ws_key_cam
and rec_keymen=ws_key_men ) loop
ws_dsp_cam :=cur01.rec_despli;
if (ws_dsp_cam='N' ) then
wn_val_dsp:=1;
return;end if;
end loop;end;
$body$
language plpgsql
;
