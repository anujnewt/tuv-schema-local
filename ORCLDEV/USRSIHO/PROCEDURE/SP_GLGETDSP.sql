create or replace procedure usrsiho."sp_glgetdsp"  (ws_key_tab varchar, ws_key_cam varchar, ws_key_men varchar, wn_val_dsp inout numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
ws_dsp_cam varchar(1);
-- define wn_val_dsp smallint;
c_despli cursor for
select rec_despli from glcoreca
where rec_keytab = ws_key_tab
and rec_keycam = ws_key_cam
and rec_keymen = ws_key_men;
begin
wn_val_dsp := 0;
for rec in c_despli loop
ws_dsp_cam := rec.rec_despli;
if ws_dsp_cam = 'N' then
wn_val_dsp := 1;
end if;
exit;
end loop;
--      begin
--         open c_despli;
--         loop
--            fetch c_despli into ws_dsp_cam;
--            if ws_dsp_cam = 'N' then
--                wn_val_dsp := 1;
--            end if;
--         end loop;
--         close c_despli;
--      end;
end;
$body$
language plpgsql
;
