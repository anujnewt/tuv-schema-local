create or replace procedure labprod.tvcdesaf_local_reestructura (client labprod.nmlopres.pre_ca2aux%type, recurp labprod.nmcoempl.emp_recurp%type , cveres labprod.nmlopres.pre_refere%type, monsol numeric, mondes numeric, cveref labprod.nmlopres.pre_refere%type, unipre numeric, unides numeric, unisal numeric, sdocap numeric, monadi numeric, keycon labprod.nmloconc.con_keycon%type, resultado inout numeric) as $body$
declare
-- pgv moved types start
--dmap moved type current package tvcdesaf_local;
--dmap moved type current package tvcdesaf_local;
v_periodo   TVCDESAF_LOCAL_periodo;
--dmap moved type current package tvcdesaf_local;
--dmap moved type current package tvcdesaf_local;
current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado TVCDESAF_LOCAL_empleado;
-- pgv moved types end
--dmap conversion comment: global temp variables moved as local temp variables
peract_temp varchar;
porcen_temp numeric;
cuofij_temp numeric;
totafi_temp numeric;
capdes_temp numeric;
fecini_temp timestamp(0);
keypre_temp numeric;
impdes_temp numeric;
total_temp numeric;
perini_temp varchar;
impdes_validado_temp numeric;
prueba_temp numeric;
--dmap conversion comment: declaration boundary ends
begin 

call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABPROD', 'TVCDESAF_LOCAL');
--dmap conversion comment: gtt declaration added
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'IMPDES', 'NUMBER',(0)::text, 'N');
insert into labprod.glwkcrys(cry_nomrep,cry_numsec,cry_chr001,cry_chr002,cry_chr003,cry_chr004,cry_chr005,cry_chr006,cry_chr007,cry_chr008,cry_chr009,cry_chr010,cry_chr011,cry_chr012,cry_chr024)
values ('CDESAF',1,client,recurp,cveres,monsol,mondes,cveref,unipre,unides,unisal,sdocap,monadi,keycon,recurp);
call tvcdesaf_local_validacion(recurp, keycon, dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'V_VAR', 'NUMBER', 'N')::numeric, current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado, v_periodo);  --existencia de TVCDESAF_LOCAL_empleado, TVCDESAF_LOCAL_periodo y concepto
if dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'V_VAR', 'NUMBER', 'N')::numeric > 0 then
resultado := dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'V_VAR', 'NUMBER', 'N')::numeric; return;
end if;
--compara rango de fechas de calendario
if (trunc(clock_timestamp()) > to_timestamp(v_periodo.fecini,'DD/MM/YY') and trunc(clock_timestamp()) < to_timestamp(v_periodo.fecfin,'DD/MM/YY')) then
resultado := 4; return; -- la n??mina se est?? calculando
end if;
--valida que exista, se le manda la bandera antigua que referer??a a reestructura: 14
if tvcdesaf_local_existe_prestamo(cveres, current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keyemp, keycon, 14) = 0 then
resultado := 3; return;
else
--verificar pr??stamo saldado
begin
select count(*) into strict total_temp from labprod.nmlopres where pre_refere = cveres
and pre_keyemp = current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keyemp and pre_ca2aux = 1 and pre_keycon = keycon
and pre_status = 2 and pre_impsal > 0 and pre_unisal > 0;
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'TOTAL', 'NUMBER',(total_temp)::text, 'N');
exception
when others then
resultado := 1234; return;
end;
if dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'TOTAL', 'NUMBER', 'N')::numeric = 0 then
if tvcdesaf_local_existe_prestamo(cveref, current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keyemp, keycon, 17) = 0 then
resultado := 3; return;
else
resultado := 10; return;
end if;
else
begin
insert into labprod.glwkcrys(cry_nomrep,cry_numsec,cry_chr001,cry_chr002,cry_chr003,cry_dec006,cry_chr024)
values ('CDESAF',2,cveres,client,keycon,current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keyemp,recurp);
select pre_ca3aux into strict impdes_temp from labprod.nmlopres
where pre_refere = cveres and pre_keyemp = current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keyemp
and pre_ca2aux = 1 and pre_keycon = keycon;
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'IMPDES', 'NUMBER',(impdes_temp)::text, 'N');
impdes_temp := dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'IMPDES', 'NUMBER', 'N')::numeric;
/*update labprod.nmlopres set pre_status = 9
where pre_refere = cveres and pre_keyemp = v_empleado.keyemp
and pre_ca2aux = 1 and pre_keycon = keycon;
total:= sql%rowcount;
*/
insert into labprod.glwkcrys('CDESAF', 3, cveres, client, keycon, current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keyemp, impdes_temp, recurp)
values ('CDESAF', 3, cveres, client, keycon, current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keyemp, impdes_temp, recurp);
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'IMPDES', 'NUMBER',(impdes_temp)::text, 'N');
exception
when others then
resultado := 16; return;
end;
end if;
capdes_temp := dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'CAPDES', 'NUMBER', 'N')::numeric;
--calcula capacidad de descuento
call labprod.sp_capdes_local (current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keyemp, capdes_temp);
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'CAPDES', 'NUMBER',(capdes_temp)::text, 'N');
capdes_temp := dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'CAPDES', 'NUMBER', 'N')::numeric;
insert into labprod.glwkcrys('CDESAF', 4, cveres, client, keycon, current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keyemp, capdes_temp, recurp)
values ('CDESAF', 4, cveres, client, keycon, current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keyemp, capdes_temp, recurp);
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'CAPDES', 'NUMBER',(capdes_temp)::text, 'N');
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'CAPDES', 'NUMBER',(dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'CAPDES', 'NUMBER', 'N')::numeric + (dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'IMPDES', 'NUMBER', 'N')::numeric * floor(30/v_periodo.diaper)))::text, 'N');
if floor(30/v_periodo.diaper)*(mondes+unides) > dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'CAPDES', 'NUMBER', 'N')::numeric then
resultado := 11;
begin
update labprod.nmlopres set pre_status = 2
where pre_refere = cveres and pre_keyemp = current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keyemp
and pre_ca2aux = '1' and pre_keycon = keycon;
exception
when others then
resultado := 16; return;
end;
capdes_temp := dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'CAPDES', 'NUMBER', 'N')::numeric;
call labprod.sp_capdes_local (current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keyemp, capdes_temp);
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'CAPDES', 'NUMBER',(capdes_temp)::text, 'N');
return;
else
--inserta
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'PERACT', 'VARCHAR',(v_periodo.period)::text, 'N');/* dmap converted statement start */
if (trunc(clock_timestamp()) > v_periodo.fecini and trunc(clock_timestamp()) < v_periodo.fecfin) then
if (oracle.substr(v_periodo.period, 5, 3))::numeric  = floor(365/v_periodo.diaper) then
peract_temp := concat( to_char((oracle.substr(v_periodo.period, 1, 4))::numeric +1), '001') ;/* dmap converted statement end */
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'PERACT', 'VARCHAR',(peract_temp)::text, 'N');
else
peract_temp := to_char((v_periodo.period)::numeric  + 1);
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'PERACT', 'VARCHAR',(peract_temp)::text, 'N');
end if;
end if;
--campos a insertar
begin
select per_fecini into strict fecini_temp from labprod.nmloperi
where per_keyper = dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'PERACT', 'VARCHAR', 'N')::varchar
and per_keypro = current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keypro;
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'FECINI', 'DATE',(fecini_temp)::text, 'N');
exception
when others then
resultado := 18; return;
end;
--se est?? mandando el fecini correcto al insert?
select nextval('labprod.nmlopres_seq') into strict keypre_temp;
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'KEYPRE', 'NUMBER',(keypre_temp)::text, 'N');
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'KEYPRE', 'NUMBER',((dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'KEYPRE', 'NUMBER', 'N')::numeric * 0.000001) + (to_char(clock_timestamp(), 'YYMMDD'))::numeric )::text, 'N');
peract_temp := dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'PERACT', 'VARCHAR', 'N')::varchar;
keypre_temp := dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'KEYPRE', 'NUMBER', 'N')::numeric;
begin
insert into labprod.nmlopres(current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keyemp, keycon, keypre_temp, cveref, clock_timestamp(), 'N', unipre, monsol, 0, 0, unides, mondes, 0, peract_temp, v_periodo.fecini, null, null, null, 0, 0, unisal, monsol, 0, 0, 0, 0, 2, clock_timestamp(), null, null, null, null, null, client, mondes + unides, current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keypro, 1, current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keypro, null, null)
values (current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keyemp, keycon, keypre_temp, cveref, clock_timestamp(), 'N', unipre, monsol, 0, 0, unides, mondes, 0, peract_temp, v_periodo.fecini, null, null, null, 0, 0, unisal, monsol, 0, 0, 0, 0, 2, clock_timestamp(), null, null, null, null, null, client, mondes + unides, current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keypro, 1, current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keypro, null, null);
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'KEYPRE', 'NUMBER',(keypre_temp)::text, 'N');
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'PERACT', 'VARCHAR',(peract_temp)::text, 'N');
exception
when others then
resultado := 15; return;
end;
-- salda el pr??stamo anterior
begin
update labprod.nmlopres set pre_status = 2, pre_impsal = 0, pre_unisal = 0
where pre_refere = cveres
and pre_keyemp = current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keyemp
and pre_ca2aux = '1'
and pre_keycon = keycon;
exception
when others then
resultado := 16; return;
end;
end if;
end if;
capdes_temp := dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'CAPDES', 'NUMBER', 'N')::numeric;
--calcula nueva capacidad de descuento
call labprod.sp_capdes_local (current_setting('tvcdesaf_local.v_empleado')::TVCDESAF_LOCAL_empleado.keyemp, capdes_temp);
call dmap_extension.p_dmap_set_pkg_var('LABPROD' , 'TVCDESAF_LOCAL', 'CAPDES', 'NUMBER',(capdes_temp)::text, 'N');
--termina
resultado :=0;end;
$body$
language plpgsql
;
