create or replace procedure usrsiho."sp_glgenerr"  (ws_nom_rep varchar, ws_ide_pcc varchar, wn_key_usu numeric, ws_hor_reg varchar, wn_sql_err numeric, wn_isa_err numeric, ws_des_err varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
ws_hor_act varchar(8) := sp_glgethor;
wn_num_fil numeric;
begin
wn_num_fil := 0;
begin
select coalesce(count(*), 0)
into strict wn_num_fil
from usrsiho.glcoresu
where res_idepro 			   = ws_nom_rep  and
res_idepcc			   = ws_ide_pcc  and
res_keyusu 			   = wn_key_usu  and
to_timestamp(res_fecini,'mm/dd/yyyy') = sp_glgetfec and
res_horreg = ws_hor_reg;
exception when no_data_found then wn_num_fil := 0;
end;
if wn_num_fil = 0 then
insert into usrsiho.glcoresu(res_idepro, res_idepcc, res_keyusu, res_fecini,
res_horini, res_horreg, res_status, res_deserr)
values (ws_nom_rep, ws_ide_pcc, wn_key_usu, sp_glgetfec,
ws_hor_act, ws_hor_reg, 'E',        ws_des_err);
else
update usrsiho.glcoresu
set res_sqlerr = wn_sql_err,
res_isaerr = wn_isa_err,
res_deserr = ws_des_err,
res_status = 'E'
where res_idepro	= ws_nom_rep  and
res_idepcc	= ws_ide_pcc  and
res_keyusu = wn_key_usu  and
to_timestamp(res_fecini,'mm/dd/yyyy') = sp_glgetfec and
res_horreg = ws_hor_reg;
end if;
/* commit; */
end;
$body$
language plpgsql
;
