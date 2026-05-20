create or replace procedure labconf.tvcontab_sp_finiquito (empleado labconf.nmwkmovt.mov_keyemp%type, periodo labconf.nmwkmovt.mov_keyper%type, proceso labconf.nmcoempl.emp_keypro%type) as $body$
declare
-- pgv moved types start
--dmap moved type current package tvcontab;
proceso	labconf.nmlohism.his_keypro%type;
--dmap moved type current package tvcontab;
periodo labconf.nmlohism.his_keyper%type;
--dmap moved type current package tvcontab;
--dmap moved type current package tvcontab;
poliza 	TVCONTAB_partefija;
-- pgv moved types end
-- eljm 12.07.2022 se envia como parametro
-- proceso   labconf.nmcoempl.emp_keypro%type;
cveversion   integer;
cveversionproc integer;
keypol labconf.nmloperi.per_keypol%type;
fecmov labconf.nmwkmovt.mov_fecmov%type;
ws_cia varchar(3);
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
-- eljm 12.07.2022 se envia como parametro
-- identifica proceso
-- select emp_keypro into proceso from labconf.nmcoempl
-- where emp_keyemp = empleado;
select per_keynom,per_keypol,pro_vercon
into strict nomina_temp, keypol, cveversionproc from labconf.nmloperi
inner join labconf.nmloproc on per_keypro = pro_keypro
where per_keypro = dmap_extension.f_dmap_get_pkg_var('LABCONF' , 'TVCONTAB', 'PROCESO', 'number', 'N')::numeric
and per_keyper = dmap_extension.f_dmap_get_pkg_var('LABCONF' , 'TVCONTAB', 'PERIODO', 'varchar2', 'N')::varchar;
call dmap_extension.p_dmap_set_pkg_var('LABCONF' , 'TVCONTAB', 'NOMINA', 'number',(nomina_temp)::text, 'N');
select case when nullif(vxn_keyver::text, '') is null then 0 else case when cveversionproc = 100 then vxn_keyver + 100 else vxn_keyver end end vxn_keyver  into strict cveversion from labconf.nmlonomi
left join labconf.tvlovxnom on nom_keynom = vxn_keynom
where nom_keynom = dmap_extension.f_dmap_get_pkg_var('LABCONF' , 'TVCONTAB', 'NOMINA', 'number', 'N')::numeric;
-- borra p¿¿¿¿liza
delete from labconf.tvwkpoli
where pol_keypol = keypol
and pol_keyemp = empleado;
-- procesa
for reg in (select mov_keyemp, mov_keypro, mov_keycon, mov_codimp, '' con_descon,
case when nullif(ver.ver_ctaref::text, '') is null then ver0.ver_ctaref else ver.ver_ctaref end con_ctaref,
case when nullif(ver.ver_ctaaux::text, '') is null then ver0.ver_ctaaux else ver.ver_ctaaux end con_ctaaux,
dep_refcon,
case when nullif(ver.ver_ietu::text, '') is null then ver0.ver_ietu else ver.ver_ietu end con_porcen,
mov_import, 0 pro_keycia, per_keypol, emp_cveban, emp_forpag, mov_keyben, mov_comfam, mov_fecmov
from labconf.nmwkmovt
inner join labconf.nmcodeps on (mov_keydep = dep_keydep)
inner join labconf.nmloperi on (mov_keyper = per_keyper and mov_keypro = per_keypro)
inner join labconf.nmcoempl on (mov_keyemp = emp_keyemp)
inner join labconf.nmloproc on (mov_keypro = pro_keypro)
inner join labconf.tvloverc ver0 on (ver0.ver_keyver = pro_vercon and mov_keycon = ver0.ver_keycon)
left join labconf.tvloverc ver on (ver.ver_keyver = cveversion and mov_keycon = ver.ver_keycon)
where mov_keypro = dmap_extension.f_dmap_get_pkg_var('LABCONF' , 'TVCONTAB', 'PROCESO', 'number', 'N')::numeric
and mov_keyper = dmap_extension.f_dmap_get_pkg_var('LABCONF' , 'TVCONTAB', 'PERIODO', 'varchar2', 'N')::varchar
and mov_keyemp = empleado
and (length(dep_refcon) = 52 or length(dep_refcon) = 26)
order by  emp_keyemp)
loop
poliza.keyemp := reg.mov_keyemp;  poliza.keypro := reg.mov_keypro;  poliza.keycon := reg.mov_keycon;  poliza.codimp := reg.mov_codimp;
poliza.descon := reg.con_descon;  poliza.keycia := reg.pro_keycia;  poliza.keypol := reg.per_keypol;  poliza.cveban := reg.emp_cveban;
poliza.forpag := reg.emp_forpag;  poliza.keyben := reg.mov_keyben;  poliza.comfam := reg.mov_comfam;  poliza.fecmov := reg.mov_fecmov;
madre_temp := dmap_extension.f_dmap_get_pkg_var('LABCONF' , 'TVCONTAB', 'MADRE', 'number', 'N')::numeric;
-- inserta registros de la p¿¿¿¿liza madre
call tvcontab_sp_inserta(poliza, reg.dep_refcon, reg.con_ctaref, reg.con_porcen, reg.mov_import, 0, madre_temp);
call dmap_extension.p_dmap_set_pkg_var('LABCONF' , 'TVCONTAB', 'MADRE', 'number',(madre_temp)::text, 'N');
madre_temp := dmap_extension.f_dmap_get_pkg_var('LABCONF' , 'TVCONTAB', 'MADRE', 'number', 'N')::numeric;
call tvcontab_sp_inserta(poliza, reg.dep_refcon, reg.con_ctaaux, reg.con_porcen, 0, reg.mov_import, madre_temp);
call dmap_extension.p_dmap_set_pkg_var('LABCONF' , 'TVCONTAB', 'MADRE', 'number',(madre_temp)::text, 'N');
hija_temp := dmap_extension.f_dmap_get_pkg_var('LABCONF' , 'TVCONTAB', 'HIJA', 'number', 'N')::numeric;
--inserta registros de la p¿¿¿¿liza hija si el departamento tiene una referencia contable con 52 caracteres
if length(poliza, reg.dep_refcon, reg.con_ctaref, reg.con_porcen, reg.mov_import, 0, hija_temp) = 52 then
if oracle.substr(poliza, reg.dep_refcon, reg.con_ctaref, reg.con_porcen, reg.mov_import, 0, hija_temp) <> '00000000' then
call tvcontab_sp_inserta(poliza, reg.dep_refcon, reg.con_ctaref, reg.con_porcen, reg.mov_import, 0, hija_temp);
call dmap_extension.p_dmap_set_pkg_var('LABCONF' , 'TVCONTAB', 'HIJA', 'number',(hija_temp)::text, 'N');
end if;
hija_temp := dmap_extension.f_dmap_get_pkg_var('LABCONF' , 'TVCONTAB', 'HIJA', 'number', 'N')::numeric;
--tipo 4
if oracle.substr(poliza, reg.dep_refcon, reg.con_ctaaux, reg.con_porcen, 0, reg.mov_import, hija_temp) <> '00000000' then
call tvcontab_sp_inserta(poliza, reg.dep_refcon, reg.con_ctaaux, reg.con_porcen, 0, reg.mov_import, hija_temp);
call dmap_extension.p_dmap_set_pkg_var('LABCONF' , 'TVCONTAB', 'HIJA', 'number',(hija_temp)::text, 'N');
end if;
end if;
end loop;
if dmap_extension.f_dmap_get_pkg_var('LABCONF' , 'TVCONTAB', 'PROCESO', 'number', 'N')::numeric = 6 or dmap_extension.f_dmap_get_pkg_var('LABCONF' , 'TVCONTAB', 'PROCESO', 'number', 'N')::numeric = 120 or dmap_extension.f_dmap_get_pkg_var('LABCONF' , 'TVCONTAB', 'PROCESO', 'number', 'N')::numeric = 139 then
if dmap_extension.f_dmap_get_pkg_var('LABCONF' , 'TVCONTAB', 'PROCESO', 'number', 'N')::numeric = 6 or dmap_extension.f_dmap_get_pkg_var('LABCONF' , 'TVCONTAB', 'PROCESO', 'number', 'N')::numeric = 120 then
ws_cia := '024';
else
ws_cia := '790';
end if;
insert into labconf.tvwkpoli(pol_keyemp,pol_keypro,pol_keycon,pol_codacu,pol_descta,         pol_cia,pol_neg,     pol_cta,pol_scta,pol_cc,pol_icia,      pol_top,    pol_ietu,pol_impcar,     pol_impabo,     pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,pol_tipo,pol_fecmov)
select pol_keyemp,pol_keypro,pol_keycon,pol_codacu,'RECLASIFICA_CONF1' pol_descta,ws_cia pol_cia,pol_neg,pol_cta,pol_scta,pol_cc,'000' pol_icia,'0' pol_top,pol_ietu,sum(pol_impabo) pol_impcar,sum(pol_impcar) pol_impabo,pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,1 pol_tipo,pol_fecmov
from labconf.tvwkpoli
where pol_keypol = keypol
and pol_cia = '552'
and pol_cc not in ('00000024','00000000')
and pol_keyemp = empleado
group by pol_keyemp, pol_keypro, pol_keycon, pol_codacu, 'RECLASIFICA_CONF1', ws_cia, pol_neg, pol_cta, pol_scta, pol_cc, '000', '0', pol_ietu, pol_keycia, pol_keypol, pol_cveban, pol_forpag, pol_keyben, pol_comfam, 1, pol_fecmov;
insert into labconf.tvwkpoli(pol_keyemp,pol_keypro,pol_keycon,pol_codacu,pol_descta,         pol_cia,pol_neg,     pol_cta,pol_scta,pol_cc,pol_icia,      pol_top,    pol_ietu,pol_impcar,     pol_impabo,     pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,pol_tipo,pol_fecmov)
select pol_keyemp,pol_keypro,pol_keycon,pol_codacu,'RECLASIFICA_CONF2' pol_descta,ws_cia pol_cia,'01' pol_neg,'485' pol_cta,pol_scta,'00799417','000' pol_icia,'0' pol_top,pol_ietu,sum(pol_impcar) pol_impcar,sum(pol_impabo) pol_impabo,pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,1 pol_tipo,pol_fecmov
from labconf.tvwkpoli
where pol_keypol = keypol
and pol_cia = '552'
and pol_cc not in ('00000024','00000000')
and pol_cta like '4%'
and pol_keyemp = empleado
group by pol_keyemp, pol_keypro, pol_keycon, pol_codacu, pol_scta,   pol_ietu, pol_keycia, pol_keypol, pol_cveban, pol_forpag, pol_keyben, pol_comfam, pol_fecmov;
insert into labconf.tvwkpoli(pol_keyemp,pol_keypro,pol_keycon,pol_codacu,pol_descta,         pol_cia,pol_neg,     pol_cta,pol_scta,pol_cc,pol_icia,      pol_top,    pol_ietu,pol_impcar,     pol_impabo,     pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,pol_tipo,pol_fecmov)
select pol_keyemp,pol_keypro,pol_keycon,pol_codacu,'RECLASIFICA_CONF2' pol_descta,ws_cia pol_cia,'01' pol_neg,'515' pol_cta,pol_scta,'00799313','000' pol_icia,'0' pol_top,pol_ietu,sum(pol_impcar) pol_impcar ,sum(pol_impabo) pol_impabo,pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,1 pol_tipo,pol_fecmov
from labconf.tvwkpoli
where pol_keypol = keypol
and pol_cia = '552'
and pol_cc not in ('00000024','00000000')
and pol_cta like '5%'
and pol_keyemp = empleado
group by pol_keyemp, pol_keypro, pol_keycon, pol_codacu, pol_scta,  pol_ietu, pol_keycia, pol_keypol, pol_cveban, pol_forpag, pol_keyben, pol_comfam, pol_fecmov;
insert into labconf.tvwkpoli(pol_keyemp,pol_keypro,pol_keycon,pol_codacu,pol_descta,         pol_cia,pol_neg,     pol_cta,pol_scta,pol_cc,pol_icia,      pol_top,    pol_ietu,pol_impcar,     pol_impabo,     pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,pol_tipo,pol_fecmov)
select pol_keyemp,pol_keypro,pol_keycon,pol_codacu,'RECLASIFICA_CONF2' pol_descta,ws_cia pol_cia,'01' pol_neg,'615' pol_cta,pol_scta,'00799851','000' pol_icia,'0' pol_top,pol_ietu,sum(pol_impcar) pol_impcar,sum(pol_impabo) pol_impabo,pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,1 pol_tipo,pol_fecmov
from labconf.tvwkpoli
where pol_keypol = keypol
and pol_cia = '552'
and pol_cc not in ('00000024','00000000')
and pol_cta like '6%'
and pol_keyemp = empleado
group by pol_keyemp, pol_keypro, pol_keycon, pol_codacu,pol_scta,  pol_ietu, pol_keycia, pol_keypol, pol_cveban, pol_forpag, pol_keyben, pol_comfam, pol_fecmov;
insert into labconf.tvwkpoli(pol_keyemp,pol_keypro,pol_keycon,pol_codacu,pol_descta,         pol_cia,pol_neg,     pol_cta,pol_scta,pol_cc,pol_icia,      pol_top,    pol_ietu,pol_impcar,     pol_impabo,     pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,pol_tipo,pol_fecmov)
select pol_keyemp,pol_keypro,pol_keycon,pol_codacu,'RECLASIFICA_CONF3' pol_descta,ws_cia pol_cia,pol_neg,pol_cta,'121339' pol_scta,pol_cc,'000' pol_icia,'0' pol_top,pol_ietu,sum(pol_impcar) pol_impcar,sum(pol_impabo) pol_impabo,pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,1 pol_tipo,pol_fecmov
from labconf.tvwkpoli
where pol_keypol = keypol
and pol_cia = '552'
and pol_cc not in ('00000024','00000000')
and pol_keyemp = empleado
group by pol_keyemp, pol_keypro, pol_keycon, pol_codacu, 'RECLASIFICA_CONF3', ws_cia, pol_neg, pol_cta, '121339', pol_cc, '000', '0', pol_ietu, pol_keycia, pol_keypol, pol_cveban, pol_forpag, pol_keyben, pol_comfam, 1, pol_fecmov;
insert into labconf.tvwkpoli(pol_keyemp,pol_keypro,pol_keycon,pol_codacu,pol_descta,         pol_cia,pol_neg,     pol_cta,pol_scta,pol_cc,pol_icia,      pol_top,    pol_ietu,pol_impcar,     pol_impabo,     pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,pol_tipo,pol_fecmov)
select pol_keyemp,pol_keypro,pol_keycon,pol_codacu,'RECLASIFICA_CONF4' pol_descta,ws_cia pol_cia,'01' pol_neg,'485' pol_cta,'121339' pol_scta,'00799417' pol_cc,'000' pol_icia,'0' pol_top,pol_ietu,sum(pol_impabo) pol_impcar,sum(pol_impcar) pol_impabo,pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,1 pol_tipo,pol_fecmov
from labconf.tvwkpoli
where pol_keypol = keypol
and pol_cia = '552'
and pol_cc not in ('00000024','00000000')
and pol_cta like '4%'
and pol_keyemp = empleado
group by pol_keyemp, pol_keypro, pol_keycon, pol_codacu,  pol_cta,  pol_cc,   pol_ietu, pol_keycia, pol_keypol, pol_cveban, pol_forpag, pol_keyben, pol_comfam, pol_fecmov;
insert into labconf.tvwkpoli(pol_keyemp,pol_keypro,pol_keycon,pol_codacu,pol_descta,         pol_cia,pol_neg,     pol_cta,pol_scta,pol_cc,pol_icia,      pol_top,    pol_ietu,pol_impcar,     pol_impabo,     pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,pol_tipo,pol_fecmov)
select pol_keyemp,pol_keypro,pol_keycon,pol_codacu,'RECLASIFICA_CONF4' pol_descta,ws_cia pol_cia,'01' pol_neg,'515' pol_cta,'121339' pol_scta,'00799313' pol_cc,'000' pol_icia,'0' pol_top,pol_ietu,sum(pol_impabo) pol_impcar,sum(pol_impcar) pol_impabo,pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,1 pol_tipo,pol_fecmov
from labconf.tvwkpoli
where pol_keypol = keypol
and pol_cia = '552'
and pol_cc not in ('00000024','00000000')
and pol_cta like '5%'
and pol_keyemp = empleado
group by pol_keyemp, pol_keypro, pol_keycon, pol_codacu,      pol_ietu, pol_keycia, pol_keypol, pol_cveban, pol_forpag, pol_keyben, pol_comfam, pol_fecmov;
insert into labconf.tvwkpoli(pol_keyemp,pol_keypro,pol_keycon,pol_codacu,pol_descta,         pol_cia,pol_neg,     pol_cta,pol_scta,pol_cc,pol_icia,      pol_top,    pol_ietu,pol_impcar,     pol_impabo,     pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,pol_tipo,pol_fecmov)
select pol_keyemp,pol_keypro,pol_keycon,pol_codacu,'RECLASIFICA_CONF4' pol_descta,ws_cia pol_cia,'01' pol_neg,'615' pol_cta,'121339' pol_scta,'00799851' pol_cc,'000' pol_icia,'0' pol_top,pol_ietu,sum(pol_impabo) pol_impcar,sum(pol_impcar) pol_impabo,pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,1 pol_tipo,pol_fecmov
from labconf.tvwkpoli
where pol_keypol = keypol
and pol_cia = '552'
and pol_cc not in ('00000024','00000000')
and pol_cta like '6%'
and pol_keyemp = empleado
group by pol_keyemp, pol_keypro, pol_keycon, pol_codacu,   pol_ietu, pol_keycia, pol_keypol, pol_cveban, pol_forpag, pol_keyben, pol_comfam, pol_fecmov;
insert into labconf.tvwkpoli(pol_keyemp,pol_keypro,pol_keycon,pol_codacu,pol_descta,         pol_cia,pol_neg,     pol_cta,pol_scta,pol_cc,pol_icia,      pol_top,    pol_ietu,pol_impcar,     pol_impabo,     pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,pol_tipo,pol_fecmov)
select pol_keyemp,pol_keypro,pol_keycon,pol_codacu,'RECLASIFICA_CONF5' pol_descta,ws_cia pol_cia,pol_neg,pol_cta,pol_scta,pol_cc,'000' pol_icia,'0' pol_top,pol_ietu,sum(pol_impabo) pol_impcar,sum(pol_impcar) pol_impabo,pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,1 pol_tipo,pol_fecmov
from labconf.tvwkpoli
where pol_keypol = keypol
and pol_cia not in ('552','284')
and pol_cc not in ('00000024','00000000')
and pol_tipo = '2'
and pol_keyemp = empleado
group by pol_keyemp, pol_keypro, pol_keycon, pol_codacu, 'RECLASIFICA_CONF5', ws_cia, pol_neg, pol_cta, pol_scta, pol_cc, '000', '0', pol_ietu, pol_keycia, pol_keypol, pol_cveban, pol_forpag, pol_keyben, pol_comfam, 1, pol_fecmov;
insert into labconf.tvwkpoli(pol_keyemp,pol_keypro,pol_keycon,pol_codacu,pol_descta,         pol_cia,pol_neg,     pol_cta,pol_scta,pol_cc,pol_icia,      pol_top,    pol_ietu,pol_impcar,     pol_impabo,     pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,pol_tipo,pol_fecmov)
select pol_keyemp,pol_keypro,pol_keycon,pol_codacu,'RECLASIFICA_CONF6' pol_descta,ws_cia pol_cia,  '01' pol_neg,pol_cta,'121339',pol_cc,'000' pol_icia,'0' pol_top,pol_ietu,sum(pol_impcar) pol_impcar,sum(pol_impabo) pol_impabo,pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,1 pol_tipo,pol_fecmov
from labconf.tvwkpoli
where pol_keypol = keypol
and pol_cia not in ('552','284')
and pol_cc not in ('00000024','00000000')
and pol_tipo = '2'
and pol_keyemp = empleado
group by pol_keyemp, pol_keypro, pol_keycon, pol_codacu,  pol_cta,  pol_cc,   pol_ietu, pol_keycia, pol_keypol, pol_cveban, pol_forpag, pol_keyben, pol_comfam, pol_fecmov;
--modificacion 30/06/2020
--reclasificacion para empresa 284
insert into labconf.tvwkpoli(pol_keyemp,pol_keypro,pol_keycon,pol_codacu,pol_descta,         pol_cia,pol_neg,     pol_cta,pol_scta,pol_cc,pol_icia,      pol_top,    pol_ietu,pol_impcar,     pol_impabo,     pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,pol_tipo,pol_fecmov)
select pol_keyemp,pol_keypro,pol_keycon,pol_codacu,'RECLASIFICA_CONF7' pol_descta,ws_cia pol_cia,pol_neg,pol_cta,pol_scta,pol_cc,'000' pol_icia,'0' pol_top,pol_ietu,sum(pol_impabo) pol_impcar,sum(pol_impcar) pol_impabo,pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,1 pol_tipo,pol_fecmov
from labconf.tvwkpoli
where pol_keypol = keypol
and pol_cia = '284'
and pol_cc not in ('00000024','00000000')
and pol_keyemp = empleado
group by pol_keyemp, pol_keypro, pol_keycon, pol_codacu, 'RECLASIFICA_CONF7', ws_cia, pol_neg, pol_cta, pol_scta, pol_cc, '000', '0', pol_ietu, pol_keycia, pol_keypol, pol_cveban, pol_forpag, pol_keyben, pol_comfam, 1, pol_fecmov;
insert into labconf.tvwkpoli(pol_keyemp,pol_keypro,pol_keycon,pol_codacu,pol_descta,         pol_cia,pol_neg,     pol_cta,pol_scta,pol_cc,pol_icia,      pol_top,    pol_ietu,pol_impcar,     pol_impabo,     pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,pol_tipo,pol_fecmov)
select pol_keyemp,pol_keypro,pol_keycon,pol_codacu,'RECLASIFICA_CONF8' pol_descta,ws_cia pol_cia,'01' pol_neg,'485' pol_cta,pol_scta,'00816417','000' pol_icia,'0' pol_top,pol_ietu,sum(pol_impcar) pol_impcar,sum(pol_impabo) pol_impabo,pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,1 pol_tipo,pol_fecmov
from labconf.tvwkpoli
where pol_keypol = keypol
and pol_cia = '284'
and pol_cc not in ('00000024','00000000')
and pol_cta like '4%'
and pol_keyemp = empleado
group by pol_keyemp, pol_keypro, pol_keycon, pol_codacu, pol_scta,   pol_ietu, pol_keycia, pol_keypol, pol_cveban, pol_forpag, pol_keyben, pol_comfam, pol_fecmov;
insert into labconf.tvwkpoli(pol_keyemp,pol_keypro,pol_keycon,pol_codacu,pol_descta,         pol_cia,pol_neg,     pol_cta,pol_scta,pol_cc,pol_icia,      pol_top,    pol_ietu,pol_impcar,     pol_impabo,     pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,pol_tipo,pol_fecmov)
select pol_keyemp,pol_keypro,pol_keycon,pol_codacu,'RECLASIFICA_CONF8' pol_descta,ws_cia pol_cia,'01' pol_neg,'515' pol_cta,pol_scta,'00816855','000' pol_icia,'0' pol_top,pol_ietu,sum(pol_impcar) pol_impcar,sum(pol_impabo) pol_impabo,pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,1 pol_tipo,pol_fecmov
from labconf.tvwkpoli
where pol_keypol = keypol
and pol_cia = '284'
and pol_cc not in ('00000024','00000000')
and pol_cta like '5%'
and pol_keyemp = empleado
group by pol_keyemp, pol_keypro, pol_keycon, pol_codacu, pol_scta,   pol_ietu, pol_keycia, pol_keypol, pol_cveban, pol_forpag, pol_keyben, pol_comfam, pol_fecmov;
insert into labconf.tvwkpoli(pol_keyemp,pol_keypro,pol_keycon,pol_codacu,pol_descta,         pol_cia,pol_neg,     pol_cta,pol_scta,pol_cc,pol_icia,      pol_top,    pol_ietu,pol_impcar,     pol_impabo,     pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,pol_tipo,pol_fecmov)
select pol_keyemp,pol_keypro,pol_keycon,pol_codacu,'RECLASIFICA_CONF8' pol_descta,ws_cia pol_cia,'01' pol_neg,'615' pol_cta,pol_scta,'00816851','000' pol_icia,'0' pol_top,pol_ietu,sum(pol_impcar) pol_impcar,sum(pol_impabo) pol_impabo,pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,1 pol_tipo,pol_fecmov
from labconf.tvwkpoli
where pol_keypol = keypol
and pol_cia = '284'
and pol_cc not in ('00000024','00000000')
and pol_cta like '6%'
and pol_keyemp = empleado
group by pol_keyemp, pol_keypro, pol_keycon, pol_codacu,pol_scta,  pol_ietu, pol_keycia, pol_keypol, pol_cveban, pol_forpag, pol_keyben, pol_comfam, pol_fecmov;
insert into labconf.tvwkpoli(pol_keyemp,pol_keypro,pol_keycon,pol_codacu,pol_descta,         pol_cia,pol_neg,     pol_cta,pol_scta,pol_cc,pol_icia,      pol_top,    pol_ietu,pol_impcar,     pol_impabo,     pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,pol_tipo,pol_fecmov)
select pol_keyemp,pol_keypro,pol_keycon,pol_codacu,'RECLASIFICA_CONF9' pol_descta,ws_cia pol_cia,pol_neg,pol_cta,'121339' pol_scta,pol_cc,'000' pol_icia,'0' pol_top,pol_ietu,sum(pol_impcar) pol_impcar,sum(pol_impabo) pol_impabo,pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,1 pol_tipo,pol_fecmov
from labconf.tvwkpoli
where pol_keypol = keypol
and pol_cia = '284'
and pol_cc not in ('00000024','00000000')
and pol_keyemp = empleado
group by pol_keyemp, pol_keypro, pol_keycon, pol_codacu, 'RECLASIFICA_CONF9', ws_cia, pol_neg, pol_cta, '121339', pol_cc, '000', '0', pol_ietu, pol_keycia, pol_keypol, pol_cveban, pol_forpag, pol_keyben, pol_comfam, 1, pol_fecmov;
insert into labconf.tvwkpoli(pol_keyemp,pol_keypro,pol_keycon,pol_codacu,pol_descta,         pol_cia,pol_neg,     pol_cta,pol_scta,pol_cc,pol_icia,      pol_top,    pol_ietu,pol_impcar,     pol_impabo,     pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,pol_tipo,pol_fecmov)
select pol_keyemp,pol_keypro,pol_keycon,pol_codacu,'RECLASIFICA_CONF10' pol_descta,ws_cia pol_cia,'01' pol_neg,'485' pol_cta,'121339' pol_scta,'00816417' pol_cc,'000' pol_icia,'0' pol_top,pol_ietu,sum(pol_impabo) pol_impcar,sum(pol_impcar) pol_impabo,pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,1 pol_tipo,pol_fecmov
from labconf.tvwkpoli
where pol_keypol = keypol
and pol_cia = '284'
and pol_cc not in ('00000024','00000000')
and pol_cta like '4%'
and pol_keyemp = empleado
group by pol_keyemp, pol_keypro, pol_keycon, pol_codacu,  pol_cta,  pol_cc,   pol_ietu, pol_keycia, pol_keypol, pol_cveban, pol_forpag, pol_keyben, pol_comfam, pol_fecmov;
insert into labconf.tvwkpoli(pol_keyemp,pol_keypro,pol_keycon,pol_codacu,pol_descta,         pol_cia,pol_neg,     pol_cta,pol_scta,pol_cc,pol_icia,      pol_top,    pol_ietu,pol_impcar,     pol_impabo,     pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,pol_tipo,pol_fecmov)
select pol_keyemp,pol_keypro,pol_keycon,pol_codacu,'RECLASIFICA_CONF10' pol_descta,ws_cia pol_cia,'01' pol_neg,'515' pol_cta,pol_scta,'00816855','000' pol_icia,'0' pol_top,pol_ietu,sum(pol_impcar) pol_impcar,sum(pol_impabo) pol_impabo,pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,1 pol_tipo,pol_fecmov
from labconf.tvwkpoli
where pol_keypol = keypol
and pol_cia = '284'
and pol_cc not in ('00000024','00000000')
and pol_cta like '5%'
and pol_keyemp = empleado
group by pol_keyemp, pol_keypro, pol_keycon, pol_codacu, 'RECLASIFICA_CONF10', ws_cia, '01', '515', pol_scta, '00816855', '000', '0', pol_ietu, pol_keycia, pol_keypol, pol_cveban, pol_forpag, pol_keyben, pol_comfam, 1, pol_fecmov;
insert into labconf.tvwkpoli(pol_keyemp,pol_keypro,pol_keycon,pol_codacu,pol_descta,         pol_cia,pol_neg,     pol_cta,pol_scta,pol_cc,pol_icia,      pol_top,    pol_ietu,pol_impcar,     pol_impabo,     pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,pol_tipo,pol_fecmov)
select pol_keyemp,pol_keypro,pol_keycon,pol_codacu,'RECLASIFICA_CONF10' pol_descta,ws_cia pol_cia,'01' pol_neg,'615' pol_cta,'121339' pol_scta,'00816851' pol_cc,'000' pol_icia,'0' pol_top,pol_ietu,sum(pol_impabo) pol_impcar,sum(pol_impcar) pol_impabo,pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,1 pol_tipo,pol_fecmov
from labconf.tvwkpoli
where pol_keypol = keypol
and pol_cia = '284'
and pol_cc not in ('00000024','00000000')
and pol_cta like '6%'
and pol_keyemp = empleado
group by pol_keyemp, pol_keypro, pol_keycon, pol_codacu,   pol_ietu, pol_keycia, pol_keypol, pol_cveban, pol_forpag, pol_keyben, pol_comfam, pol_fecmov;
end if;
---fin contable
end;
$body$
language plpgsql
;
