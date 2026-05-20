create or replace procedure labconf.tvcontab_sp_contable (proceso labconf.nmlohism.his_keypro%type, periodo labconf.nmlohism.his_keyper%type) as $body$
declare
-- pgv moved types start
--dmap moved type current package tvcontab;
periodo labconf.nmlohism.his_keyper%type;
--dmap moved type current package tvcontab;
proceso	labconf.nmlohism.his_keypro%type;
--dmap moved type current package tvcontab;
--dmap moved type current package tvcontab;
poliza 	TVCONTAB_partefija;
--dmap moved type current package tvcontab;
--dmap moved type current package tvcontab;
current_setting('tvcontab.args')::TVCONTAB_argumentos 		TVCONTAB_argumentos;
-- pgv moved types end
total     integer;
i         integer;
cveversion   integer;
cvepoliza labconf.nmloperi.per_keypol%type;
cveversionproc integer;
--dmap conversion comment: global temp variables moved as local temp variables
proceso_temp numeric;
periodo_temp varchar;
nomina_temp numeric;
dr_ciaori_temp varchar;
dr_ciades_temp varchar;
dr_concep_temp varchar;
dr_cta_temp varchar;
dr_scta_temp varchar;
madre_temp numeric;
hija_temp numeric;
--dmap conversion comment: declaration boundary ends
reg record;
begin 

call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABCONF', 'TVCONTAB');
--dmap conversion comment: gtt declaration added
-- marcar el periodo per_selper = p para procesar
update labconf.nmloperi set per_persel = 'P' where per_keyper = dmap_extension.f_dmap_get_pkg_var('LABCONF' , 'TVCONTAB', 'PERIODO', 'varchar2', 'N')::varchar and per_keypro = dmap_extension.f_dmap_get_pkg_var('LABCONF' , 'TVCONTAB', 'PROCESO', 'number', 'N')::numeric;
/* commit; */
select per_keynom,per_keypol,pro_vercon
into strict nomina_temp, cvepoliza, cveversionproc from labconf.nmloperi
inner join labconf.nmloproc on per_keypro = pro_keypro
where per_keypro = dmap_extension.f_dmap_get_pkg_var('LABCONF' , 'TVCONTAB', 'PROCESO', 'number', 'N')::numeric
and per_keyper = dmap_extension.f_dmap_get_pkg_var('LABCONF' , 'TVCONTAB', 'PERIODO', 'varchar2', 'N')::varchar;
call dmap_extension.p_dmap_set_pkg_var('LABCONF' , 'TVCONTAB', 'NOMINA', 'number',(nomina_temp)::text, 'N');
select case when nullif(vxn_keyver::text, '') is null then 0 else case when cveversionproc = 100 then vxn_keyver + 100 else vxn_keyver end end vxn_keyver  into strict cveversion from labconf.nmlonomi
left join labconf.tvlovxnom on nom_keynom = vxn_keynom
where nom_keynom = dmap_extension.f_dmap_get_pkg_var('LABCONF' , 'TVCONTAB', 'NOMINA', 'number', 'N')::numeric;
-- -------------------------------------------------------------------------------------------------------------------
-- eljm recupera las opcis del programa para doble registro
-- dr_ciaori tvwkpoli.pol_cia%type;  	-- cia origen para aplicar doble registro		019			opci11
select  coalesce(pam_folini, '019')
into strict dr_ciaori_temp from    labconf.glcopams
where   pam_keypar = (select  pam_folini
from    labconf.glcopams
where   pam_keypar = '00'
and     pam_cvesec = 'polcon')
and     pam_cvesec = 'OPCI11';
call dmap_extension.p_dmap_set_pkg_var('LABCONF' , 'TVCONTAB', 'DR_CIAORI', 'varchar2',(dr_ciaori_temp)::text, 'N');
-- dr_ciades tvwkpoli.pol_cia%type;  	-- cia destino para aplicar doble registro	522			opci12
select  coalesce(pam_folini, '522')
into strict dr_ciades_temp from    labconf.glcopams
where   pam_keypar = (select  pam_folini
from    labconf.glcopams
where   pam_keypar = '00'
and     pam_cvesec = 'polcon')
and     pam_cvesec = 'OPCI12';
call dmap_extension.p_dmap_set_pkg_var('LABCONF' , 'TVCONTAB', 'DR_CIADES', 'varchar2',(dr_ciades_temp)::text, 'N');
-- dr_concep nmlohism.his_keycon%type; -- cve concepto de comisiones					    	m39			opci13
select  coalesce(pam_folini, 'M39')
into strict dr_concep_temp from    labconf.glcopams
where   pam_keypar = (select  pam_folini
from    labconf.glcopams
where   pam_keypar = '00'
and     pam_cvesec = 'polcon')
and     pam_cvesec = 'OPCI13';
call dmap_extension.p_dmap_set_pkg_var('LABCONF' , 'TVCONTAB', 'DR_CONCEP', 'varchar2',(dr_concep_temp)::text, 'N');
-- dr_cta   	tvwkpoli.pol_cta%type;		-- cta para afectacion								      126			opci14
select  coalesce(pam_folini, '126')
into strict dr_cta_temp from    labconf.glcopams
where   pam_keypar = (select  pam_folini
from    labconf.glcopams
where   pam_keypar = '00'
and     pam_cvesec = 'polcon')
and     pam_cvesec = 'OPCI14';
call dmap_extension.p_dmap_set_pkg_var('LABCONF' , 'TVCONTAB', 'DR_CTA', 'varchar2',(dr_cta_temp)::text, 'N');
-- dr_scta   tvwkpoli.pol_scta%type;  	-- scta para afectacion											012002	opci15
select  coalesce(pam_folini, '012002')
into strict dr_scta_temp from    labconf.glcopams
where   pam_keypar = (select  pam_folini
from    labconf.glcopams
where   pam_keypar = '00'
and     pam_cvesec = 'polcon')
and     pam_cvesec = 'OPCI15';
call dmap_extension.p_dmap_set_pkg_var('LABCONF' , 'TVCONTAB', 'DR_SCTA', 'varchar2',(dr_scta_temp)::text, 'N');
-- -------------------------------------------------------------------------------------------------------------------
-- borra p¿¿¿¿liza
delete from labconf.tvwkpoli where pol_keypol = cvepoliza;
/* commit; */
-- cuenta
select count(*) into strict total from labconf.nmlohism
inner join labconf.nmcodeps on (his_keydep = dep_keydep)
inner join labconf.nmloperi on (his_keyper = per_keyper and his_keypro = per_keypro)
inner join labconf.nmcoempl on (his_keyemp = emp_keyemp)
inner join labconf.nmloproc on (his_keypro = pro_keypro)
inner join labconf.tvloverc ver0 on (ver0.ver_keyver = pro_vercon and his_keycon = ver0.ver_keycon)
left join labconf.tvloverc ver on (ver.ver_keyver = cveversion and his_keycon = ver.ver_keycon and ver.ver_keyver <>0)
where his_keyper = dmap_extension.f_dmap_get_pkg_var('LABCONF' , 'TVCONTAB', 'PERIODO', 'varchar2', 'N')::varchar
and his_keypro = dmap_extension.f_dmap_get_pkg_var('LABCONF' , 'TVCONTAB', 'PROCESO', 'number', 'N')::numeric
and (length(dep_refcon) = 52 or length(dep_refcon) = 26);
if total = 0 then
update labconf.nmloperi set per_persel = null where per_keyper = dmap_extension.f_dmap_get_pkg_var('LABCONF' , 'TVCONTAB', 'PERIODO', 'varchar2', 'N')::varchar and per_keypro = dmap_extension.f_dmap_get_pkg_var('LABCONF' , 'TVCONTAB', 'PROCESO', 'number', 'N')::numeric;
update labconf.glcoresu set res_status = 'T',res_totreg = 0,res_numreg = 0
where res_idepro = current_setting('tvcontab.args')::TVCONTAB_argumentos.idepro and res_idepcc = current_setting('tvcontab.args')::TVCONTAB_argumentos.idepcc and res_fecini = current_setting('tvcontab.args')::TVCONTAB_argumentos.fecini and res_horini = current_setting('tvcontab.args')::TVCONTAB_argumentos.horini;
/* commit; */
return;
end if;
-- inicializa contador
i := 1;
-- inicializa registro en glcoresu (el registro ya fue insertado desde el programa del cliente
update labconf.glcoresu set res_numreg = i, res_totreg = total
where res_idepro = current_setting('tvcontab.args')::TVCONTAB_argumentos.idepro and res_idepcc = current_setting('tvcontab.args')::TVCONTAB_argumentos.idepcc and res_keyusu = current_setting('tvcontab.args')::TVCONTAB_argumentos.keyusu
and res_fecini = current_setting('tvcontab.args')::TVCONTAB_argumentos.fecini and res_horini = current_setting('tvcontab.args')::TVCONTAB_argumentos.horini;
-- procesa
for reg in (select his_keyemp, his_keypro, his_keycon, his_codimp, '' con_descon,
case when nullif(ver.ver_ctaref::text, '') is null then ver0.ver_ctaref else ver.ver_ctaref end con_ctaref,
case when nullif(ver.ver_ctaaux::text, '') is null then ver0.ver_ctaaux else ver.ver_ctaaux end con_ctaaux,
dep_refcon,
case when nullif(ver.ver_ietu::text, '') is null then ver0.ver_ietu else ver.ver_ietu end con_porcen,
his_import, 0 pro_keycia, per_keypol, emp_cveban, emp_forpag, his_keyben, his_comfam, his_fecmov
from labconf.nmlohism
inner join labconf.nmcodeps on (his_keydep = dep_keydep)
inner join labconf.nmloperi on (his_keyper = per_keyper and his_keypro = per_keypro)
inner join labconf.nmcoempl on (his_keyemp = emp_keyemp)
inner join labconf.nmloproc on (his_keypro = pro_keypro)
inner join labconf.tvloverc ver0 on (ver0.ver_keyver = pro_vercon and his_keycon = ver0.ver_keycon)
left join labconf.tvloverc ver on (ver.ver_keyver = cveversion and his_keycon = ver.ver_keycon and ver.ver_keyver <>0)
where his_keyper = dmap_extension.f_dmap_get_pkg_var('LABCONF' , 'TVCONTAB', 'PERIODO', 'varchar2', 'N')::varchar
and his_keypro = dmap_extension.f_dmap_get_pkg_var('LABCONF' , 'TVCONTAB', 'PROCESO', 'number', 'N')::numeric
and (length(dep_refcon) = 52 or length(dep_refcon) = 26)
order by  emp_keyemp)
loop
poliza.keyemp := reg.his_keyemp;  poliza.keypro := reg.his_keypro;
poliza.keycon := reg.his_keycon;  poliza.codimp := reg.his_codimp;
poliza.descon := reg.con_descon;  poliza.keycia := reg.pro_keycia;
poliza.keypol := reg.per_keypol;  poliza.cveban := reg.emp_cveban;
poliza.forpag := reg.emp_forpag;  poliza.keyben := reg.his_keyben;
poliza.comfam := reg.his_comfam;  poliza.fecmov := reg.his_fecmov;
madre_temp := dmap_extension.f_dmap_get_pkg_var('LABCONF' , 'TVCONTAB', 'MADRE', 'number', 'N')::numeric;
-- inserta registro tipo 1
call tvcontab_sp_inserta(poliza, reg.dep_refcon, reg.con_ctaref, reg.con_porcen, reg.his_import, 0, madre_temp);
call dmap_extension.p_dmap_set_pkg_var('LABCONF' , 'TVCONTAB', 'MADRE', 'number',(madre_temp)::text, 'N');
madre_temp := dmap_extension.f_dmap_get_pkg_var('LABCONF' , 'TVCONTAB', 'MADRE', 'number', 'N')::numeric;
-- inserta registro tipo 2
call tvcontab_sp_inserta(poliza, reg.dep_refcon, reg.con_ctaaux, reg.con_porcen, 0, reg.his_import, madre_temp);
call dmap_extension.p_dmap_set_pkg_var('LABCONF' , 'TVCONTAB', 'MADRE', 'number',(madre_temp)::text, 'N');
hija_temp := dmap_extension.f_dmap_get_pkg_var('LABCONF' , 'TVCONTAB', 'HIJA', 'number', 'N')::numeric;
if length(poliza, reg.dep_refcon, reg.con_ctaref, reg.con_porcen, reg.his_import, 0, hija_temp) = 52 then
--tipo 3
if oracle.substr(poliza, reg.dep_refcon, reg.con_ctaref, reg.con_porcen, reg.his_import, 0, hija_temp) <> '00000000' then
call tvcontab_sp_inserta(poliza, reg.dep_refcon, reg.con_ctaref, reg.con_porcen, reg.his_import, 0, hija_temp);
call dmap_extension.p_dmap_set_pkg_var('LABCONF' , 'TVCONTAB', 'HIJA', 'number',(hija_temp)::text, 'N');
end if;
hija_temp := dmap_extension.f_dmap_get_pkg_var('LABCONF' , 'TVCONTAB', 'HIJA', 'number', 'N')::numeric;
--tipo 4
if oracle.substr(poliza, reg.dep_refcon, reg.con_ctaaux, reg.con_porcen, 0, reg.his_import, hija_temp) <> '00000000' then
call tvcontab_sp_inserta(poliza, reg.dep_refcon, reg.con_ctaaux, reg.con_porcen, 0, reg.his_import, hija_temp);
call dmap_extension.p_dmap_set_pkg_var('LABCONF' , 'TVCONTAB', 'HIJA', 'number',(hija_temp)::text, 'N');
end if;
end if;
-- actualiza glcoresu cada n registros
if (i mod dmap_extension.f_dmap_get_pkg_var('LABCONF' , 'TVCONTAB', 'REGS', 'INTEGER', 'N')::integer = 0) then
update labconf.glcoresu set res_numreg = i
where res_idepro = current_setting('tvcontab.args')::TVCONTAB_argumentos.idepro and res_idepcc = current_setting('tvcontab.args')::TVCONTAB_argumentos.idepcc
and res_keyusu = current_setting('tvcontab.args')::TVCONTAB_argumentos.keyusu and res_fecini = current_setting('tvcontab.args')::TVCONTAB_argumentos.fecini and res_horini = current_setting('tvcontab.args')::TVCONTAB_argumentos.horini;
end if;
/* commit; */
-- actualiza contador
i := i + 1;
end loop;
periodo_temp := dmap_extension.f_dmap_get_pkg_var('LABCONF' , 'TVCONTAB', 'PERIODO', 'varchar2', 'N')::varchar;
proceso_temp := dmap_extension.f_dmap_get_pkg_var('LABCONF' , 'TVCONTAB', 'PROCESO', 'number', 'N')::numeric;
--reclasificar las incidencias de intelectus
call tvcontab_sp_reclasifica(proceso_temp, periodo_temp, cvepoliza);
call dmap_extension.p_dmap_set_pkg_var('LABCONF' , 'TVCONTAB', 'PROCESO', 'number',(proceso_temp)::text, 'N');
call dmap_extension.p_dmap_set_pkg_var('LABCONF' , 'TVCONTAB', 'PERIODO', 'varchar2',(periodo_temp)::text, 'N');
periodo_temp := dmap_extension.f_dmap_get_pkg_var('LABCONF' , 'TVCONTAB', 'PERIODO', 'varchar2', 'N')::varchar;
proceso_temp := dmap_extension.f_dmap_get_pkg_var('LABCONF' , 'TVCONTAB', 'PROCESO', 'number', 'N')::numeric;
--reclasificar confidencial proceso 355
call tvcontab_sp_reclasifica2(proceso_temp, periodo_temp, cvepoliza);
call dmap_extension.p_dmap_set_pkg_var('LABCONF' , 'TVCONTAB', 'PROCESO', 'number',(proceso_temp)::text, 'N');
call dmap_extension.p_dmap_set_pkg_var('LABCONF' , 'TVCONTAB', 'PERIODO', 'varchar2',(periodo_temp)::text, 'N');
-- desmarcar el periodo per_selper =  para terminar
update labconf.nmloperi set per_persel = null where per_keyper = dmap_extension.f_dmap_get_pkg_var('LABCONF' , 'TVCONTAB', 'PERIODO', 'varchar2', 'N')::varchar and per_keypro = dmap_extension.f_dmap_get_pkg_var('LABCONF' , 'TVCONTAB', 'PROCESO', 'number', 'N')::numeric;
-- actualizar el registro en glcoresu a t
update labconf.glcoresu set res_numreg = total, res_status = 'T'
where res_idepro = current_setting('tvcontab.args')::TVCONTAB_argumentos.idepro and res_idepcc = current_setting('tvcontab.args')::TVCONTAB_argumentos.idepcc
and res_keyusu = current_setting('tvcontab.args')::TVCONTAB_argumentos.keyusu and res_fecini = current_setting('tvcontab.args')::TVCONTAB_argumentos.fecini and res_horini = current_setting('tvcontab.args')::TVCONTAB_argumentos.horini;
---fin contable
end;
$body$
language plpgsql
;
