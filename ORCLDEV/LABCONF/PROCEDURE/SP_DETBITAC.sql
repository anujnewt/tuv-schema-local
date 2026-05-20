create or replace procedure labconf."sp_detbitac"  (wn_key_usu numeric, ws_ide_pcc varchar, ws_key_tab varchar, ws_key_cam varchar, ws_val_ant varchar, ws_val_act varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
ws_fec_mov timestamp(0)     := sp_glgetfec;
ws_hor_mov varchar(16) := sp_glgethor;
ws_ide_bit varchar(10) := '_BITACORA_';
c_glwkcrys record;
begin
for c_glwkcrys in (select cry_dat001, cry_chr012
from glwkcrys
where cry_nomrep = ws_ide_bit and
cry_idepcc = ws_ide_pcc and
cry_keyusu = wn_key_usu) loop
ws_fec_mov := c_glwkcrys.cry_dat001;
ws_hor_mov := c_glwkcrys.cry_chr012;
end loop;
insert into glcodetb(det_keyusu, det_fecmov, det_hormov, det_keytab,
det_keycam, det_valant, det_valact)
values (wn_key_usu, ws_fec_mov, oracle.substr(ws_hor_mov, 1, 8), ws_key_tab,
ws_key_cam, ws_val_ant, ws_val_act);
/* commit; */
exception
when others then
call sp_glgenerr ('DETBITAC', ws_ide_pcc, wn_key_usu, sp_glgethor,
sqlstate, 0, oracle.substr(sqlerrm, 1, 60));end;
$body$
language plpgsql
;
