create or replace procedure labppto."sp_usuarios"  (wn_key_usu numeric, ws_nom_usu varchar, ws_key_est varchar, ws_key_dep varchar, ws_cve_usu varchar, ws_key_men varchar, ws_mas_opc varchar, ws_sta_tus varchar, wn_fec_dur numeric, ws_tip_usu varchar, ws_per_men varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
ws_fec_mov timestamp(0) := labppto.sp_glgetfec;
ws_hor_mov varchar(5) := oracle.substr(labppto.sp_glgethor, 1, 5);
begin
insert into labppto.glcousua(usu_keyusu, usu_nomusu, usu_keyest, usu_keydep, usu_fecalt,
usu_horalt, usu_cveusu, usu_keymen, usu_masopc, usu_status,
usu_acceso, usu_passwd, usu_fecdur, usu_tipusu, usu_permen)
values (wn_key_usu, ws_nom_usu, ws_key_est, ws_key_dep, ws_fec_mov,
ws_hor_mov, ws_cve_usu, ws_key_men, ws_mas_opc, ws_sta_tus,
ws_fec_mov, ws_fec_mov, wn_fec_dur, ws_tip_usu, ws_per_men);
/* commit; */
exception
when others then
call labppto.sp_glgenerr ('USUARIOS', 'ID DE PC', 0, labppto.sp_glgethor, sqlstate, 0, oracle.substr(sqlerrm, 1, 60));end;
$body$
language plpgsql
;
