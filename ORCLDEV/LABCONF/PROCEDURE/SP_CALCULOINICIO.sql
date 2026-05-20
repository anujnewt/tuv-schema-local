create or replace procedure labconf."sp_calculoinicio"  (wn_key_pro numeric, ws_key_per varchar, ws_nom_rep varchar, ws_fec_ini varchar, ws_hor_ini varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
result numeric(10) := 1;
begin
/*insertar codigo de validaci?*/
delete from labconf.glwkcrys
where cry_nomrep = ws_nom_rep
and cry_numsec = -1
and cry_dec006 = wn_key_pro
and cry_chr001 = ws_key_per
and cry_chr012 = ws_fec_ini
and cry_chr023 = ws_hor_ini;
insert into labconf.glwkcrys(cry_nomrep,cry_numsec,cry_dec006,cry_chr001,cry_chr012,cry_chr023,cry_dec007)
values (ws_nom_rep,-1,wn_key_pro,ws_key_per,ws_fec_ini,ws_hor_ini,result);end;
$body$
language plpgsql
;
