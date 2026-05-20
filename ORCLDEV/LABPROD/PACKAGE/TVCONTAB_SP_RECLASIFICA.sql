create or replace procedure labprod.tvcontab_sp_reclasifica (proceso labprod.nmlohism.his_keypro%type, periodo labprod.nmlohism.his_keyper%type,keypol labprod.tvwkpoli.pol_keypol%type) as $body$
declare
-- pgv moved types start
-- pgv moved types end
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
begin 

call dmap_extension.pkg_var_dmap_tab_to_gtt_init('LABPROD', 'TVCONTAB');
--dmap conversion comment: gtt declaration added
insert into labprod.tvwkpoli
select pol_keyemp,pol_keypro,pol_keycon,pol_codacu,'RECLASIFICA1',pol_cia,pol_neg,pol_cta,pol_scta,pol_cc,pol_icia,pol_top,pol_ietu,0,sum(inc_import),pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,pol_tipo,pol_fecmov
from (select distinct pol_keyemp,pol_keypro,pol_keycon,pol_codacu,pol_cia,pol_neg,pol_cta,pol_scta,pol_cc,pol_icia,pol_top,pol_ietu,pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,pol_tipo,pol_fecmov
from labprod.tvwkpoli
where pol_keypol = keypol
and pol_keycon in (select pam_cvesec from labprod.glcopams where pam_keypar = 'CONT')
and pol_cc > '00000000'
and nullif(pol_descta::text, '') is null
and pol_tipo = 1) alias2,
labprod.tvloinct
where pol_keypro = inc_keypro and inc_keyper = oracle.substr(pol_keypol,4,7) and pol_keyemp = inc_keyemp and pol_keycon = inc_keycon
and inc_keypro = proceso
and inc_keyper = periodo
group by pol_keyemp, pol_keypro, pol_keycon, pol_codacu, pol_cia, pol_neg, pol_cta, pol_scta, pol_cc, pol_icia, pol_top, pol_ietu, pol_keycia, pol_keypol, pol_cveban, pol_forpag, pol_keyben, pol_comfam, pol_tipo, pol_fecmov
order by  pol_keyemp, pol_keypro, pol_keycon, pol_codacu, pol_cia, pol_neg, pol_cta, pol_scta, pol_cc, pol_icia, pol_top, pol_ietu, pol_keycia, pol_keypol, pol_cveban, pol_forpag, pol_keyben, pol_comfam, pol_tipo, pol_fecmov;
insert into labprod.tvwkpoli
select pol_keyemp,pol_keypro,pol_keycon,pol_codacu,'RECLASIFICA2',pol_cia,cen_neg,cen_cta,pol_scta,inc_keycen,pol_icia,pol_top,pol_ietu,sum(inc_import),0,pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,pol_tipo,pol_fecmov
from (select distinct pol_keyemp,pol_keypro,pol_keycon,pol_codacu,pol_cia,pol_neg,pol_cta,pol_scta,pol_cc,pol_icia,pol_top,pol_ietu,pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,pol_tipo,pol_fecmov
from labprod.tvwkpoli
where pol_keypol  = keypol
and pol_keycon in (select pam_cvesec from labprod.glcopams where pam_keypar = 'CONT')
and pol_cc > '00000000'
and nullif(pol_descta::text, '') is null
and pol_tipo = 1) alias2,
labprod.tvloinct,
labprod.nmlocepro
where pol_keypro = inc_keypro and inc_keyper = oracle.substr(pol_keypol,4,7) and pol_keyemp = inc_keyemp and pol_keycon = inc_keycon and inc_keycen = cen_keycen
and inc_keypro = proceso
and inc_keyper = periodo
group by pol_keyemp, pol_keypro, pol_keycon, pol_codacu, pol_cia,cen_neg,cen_cta, pol_scta, inc_keycen, pol_icia, pol_top, pol_ietu, pol_keycia, pol_keypol, pol_cveban, pol_forpag, pol_keyben, pol_comfam, pol_tipo, pol_fecmov;
/* commit; */
if dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCONTAB', 'PROCESO', 'number', 'N')::numeric = 6 or dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCONTAB', 'PROCESO', 'number', 'N')::numeric = 120 or dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCONTAB', 'PROCESO', 'number', 'N')::numeric = 139 then
if dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCONTAB', 'PROCESO', 'number', 'N')::numeric = 6 or dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCONTAB', 'PROCESO', 'number', 'N')::numeric = 120 then
ws_cia := '024';
else
ws_cia := '790';
end if;
insert into labprod.tvwkpoli(pol_keyemp,pol_keypro,pol_keycon,pol_codacu,pol_descta,         pol_cia,pol_neg,     pol_cta,pol_scta,pol_cc,pol_icia,      pol_top,    pol_ietu,pol_impcar,     pol_impabo,     pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,pol_tipo,pol_fecmov)
select pol_keyemp,pol_keypro,pol_keycon,pol_codacu,'RECLASIFICA_CONF1' pol_descta,ws_cia pol_cia,pol_neg,pol_cta,pol_scta,pol_cc,'000' pol_icia,'0' pol_top,pol_ietu,sum(pol_impabo) pol_impcar,sum(pol_impcar) pol_impabo,pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,1 pol_tipo,pol_fecmov
from labprod.tvwkpoli
where pol_keypol = keypol
and pol_cia = '552'
and pol_cc not in ('00000024','00000000')
group by pol_keyemp, pol_keypro, pol_keycon, pol_codacu,pol_neg,  pol_cta, pol_scta, pol_cc,   pol_ietu, pol_keycia, pol_keypol, pol_cveban, pol_forpag, pol_keyben, pol_comfam, pol_fecmov;
insert into labprod.tvwkpoli(pol_keyemp,pol_keypro,pol_keycon,pol_codacu,pol_descta,         pol_cia,pol_neg,     pol_cta,pol_scta,pol_cc,pol_icia,      pol_top,    pol_ietu,pol_impcar,     pol_impabo,     pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,pol_tipo,pol_fecmov)
select pol_keyemp,pol_keypro,pol_keycon,pol_codacu,'RECLASIFICA_CONF2' pol_descta,ws_cia pol_cia,'01' pol_neg,'485' pol_cta,pol_scta,'00799417','000' pol_icia,'0' pol_top,pol_ietu,sum(pol_impcar) pol_impcar,sum(pol_impabo) pol_impabo,pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,1 pol_tipo,pol_fecmov
from labprod.tvwkpoli
where pol_keypol = keypol
and pol_cia = '552'
and pol_cc not in ('00000024','00000000')
and pol_cta like '4%'
group by pol_keyemp, pol_keypro, pol_keycon, pol_codacu, pol_scta,   pol_ietu, pol_keycia, pol_keypol, pol_cveban, pol_forpag, pol_keyben, pol_comfam, pol_fecmov;
insert into labprod.tvwkpoli(pol_keyemp,pol_keypro,pol_keycon,pol_codacu,pol_descta,         pol_cia,pol_neg,     pol_cta,pol_scta,pol_cc,pol_icia,      pol_top,    pol_ietu,pol_impcar,     pol_impabo,     pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,pol_tipo,pol_fecmov)
select pol_keyemp,pol_keypro,pol_keycon,pol_codacu,'RECLASIFICA_CONF2' pol_descta,ws_cia pol_cia,'01' pol_neg,'515' pol_cta,pol_scta,'00799313','000' pol_icia,'0' pol_top,pol_ietu,sum(pol_impcar) pol_impcar ,sum(pol_impabo) pol_impabo,pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,1 pol_tipo,pol_fecmov
from labprod.tvwkpoli
where pol_keypol = keypol
and pol_cia = '552'
and pol_cc not in ('00000024','00000000')
and pol_cta like '5%'
group by pol_keyemp, pol_keypro, pol_keycon, pol_codacu, pol_scta,  pol_ietu, pol_keycia, pol_keypol, pol_cveban, pol_forpag, pol_keyben, pol_comfam, pol_fecmov;
insert into labprod.tvwkpoli(pol_keyemp,pol_keypro,pol_keycon,pol_codacu,pol_descta,         pol_cia,pol_neg,     pol_cta,pol_scta,pol_cc,pol_icia,      pol_top,    pol_ietu,pol_impcar,     pol_impabo,     pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,pol_tipo,pol_fecmov)
select pol_keyemp,pol_keypro,pol_keycon,pol_codacu,'RECLASIFICA_CONF2' pol_descta,ws_cia pol_cia,'01' pol_neg,'615' pol_cta,pol_scta,'00799851','000' pol_icia,'0' pol_top,pol_ietu,sum(pol_impcar) pol_impcar,sum(pol_impabo) pol_impabo,pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,1 pol_tipo,pol_fecmov
from labprod.tvwkpoli
where pol_keypol = keypol
and pol_cia = '552'
and pol_cc not in ('00000024','00000000')
and pol_cta like '6%'
group by pol_keyemp, pol_keypro, pol_keycon, pol_codacu,pol_scta,  pol_ietu, pol_keycia, pol_keypol, pol_cveban, pol_forpag, pol_keyben, pol_comfam, pol_fecmov;
insert into labprod.tvwkpoli(pol_keyemp,pol_keypro,pol_keycon,pol_codacu,pol_descta,         pol_cia,pol_neg,     pol_cta,pol_scta,pol_cc,pol_icia,      pol_top,    pol_ietu,pol_impcar,     pol_impabo,     pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,pol_tipo,pol_fecmov)
select pol_keyemp,pol_keypro,pol_keycon,pol_codacu,'RECLASIFICA_CONF3' pol_descta,ws_cia pol_cia,pol_neg,pol_cta,'121339' pol_scta,pol_cc,'000' pol_icia,'0' pol_top,pol_ietu,sum(pol_impcar) pol_impcar,sum(pol_impabo) pol_impabo,pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,1 pol_tipo,pol_fecmov
from labprod.tvwkpoli
where pol_keypol = keypol
and pol_cia = '552'
and pol_cc not in ('00000024','00000000')
group by pol_keyemp, pol_keypro, pol_keycon, pol_codacu,pol_neg, pol_cta,  pol_cc,   pol_ietu, pol_keycia, pol_keypol, pol_cveban, pol_forpag, pol_keyben, pol_comfam, pol_fecmov;
insert into labprod.tvwkpoli(pol_keyemp,pol_keypro,pol_keycon,pol_codacu,pol_descta,         pol_cia,pol_neg,     pol_cta,pol_scta,pol_cc,pol_icia,      pol_top,    pol_ietu,pol_impcar,     pol_impabo,     pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,pol_tipo,pol_fecmov)
select pol_keyemp,pol_keypro,pol_keycon,pol_codacu,'RECLASIFICA_CONF4' pol_descta,ws_cia pol_cia,'01' pol_neg,'485' pol_cta,'121339' pol_scta,'00799417' pol_cc,'000' pol_icia,'0' pol_top,pol_ietu,sum(pol_impabo) pol_impcar,sum(pol_impcar) pol_impabo,pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,1 pol_tipo,pol_fecmov
from labprod.tvwkpoli
where pol_keypol = keypol
and pol_cia = '552'
and pol_cc not in ('00000024','00000000')
and pol_cta like '4%'
group by pol_keyemp, pol_keypro, pol_keycon, pol_codacu,  pol_cta,  pol_cc,   pol_ietu, pol_keycia, pol_keypol, pol_cveban, pol_forpag, pol_keyben, pol_comfam, pol_fecmov;
insert into labprod.tvwkpoli(pol_keyemp,pol_keypro,pol_keycon,pol_codacu,pol_descta,         pol_cia,pol_neg,     pol_cta,pol_scta,pol_cc,pol_icia,      pol_top,    pol_ietu,pol_impcar,     pol_impabo,     pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,pol_tipo,pol_fecmov)
select pol_keyemp,pol_keypro,pol_keycon,pol_codacu,'RECLASIFICA_CONF4' pol_descta,ws_cia pol_cia,'01' pol_neg,'515' pol_cta,'121339' pol_scta,'00799313' pol_cc,'000' pol_icia,'0' pol_top,pol_ietu,sum(pol_impabo) pol_impcar,sum(pol_impcar) pol_impabo,pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,1 pol_tipo,pol_fecmov
from labprod.tvwkpoli
where pol_keypol = keypol
and pol_cia = '552'
and pol_cc not in ('00000024','00000000')
and pol_cta like '5%'
group by pol_keyemp, pol_keypro, pol_keycon, pol_codacu,      pol_ietu, pol_keycia, pol_keypol, pol_cveban, pol_forpag, pol_keyben, pol_comfam, pol_fecmov;
insert into labprod.tvwkpoli(pol_keyemp,pol_keypro,pol_keycon,pol_codacu,pol_descta,         pol_cia,pol_neg,     pol_cta,pol_scta,pol_cc,pol_icia,      pol_top,    pol_ietu,pol_impcar,     pol_impabo,     pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,pol_tipo,pol_fecmov)
select pol_keyemp,pol_keypro,pol_keycon,pol_codacu,'RECLASIFICA_CONF4' pol_descta,ws_cia pol_cia,'01' pol_neg,'615' pol_cta,'121339' pol_scta,'00799851' pol_cc,'000' pol_icia,'0' pol_top,pol_ietu,sum(pol_impabo) pol_impcar,sum(pol_impcar) pol_impabo,pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,1 pol_tipo,pol_fecmov
from labprod.tvwkpoli
where pol_keypol = keypol
and pol_cia = '552'
and pol_cc not in ('00000024','00000000')
and pol_cta like '6%'
group by pol_keyemp, pol_keypro, pol_keycon, pol_codacu,   pol_ietu, pol_keycia, pol_keypol, pol_cveban, pol_forpag, pol_keyben, pol_comfam, pol_fecmov;
insert into labprod.tvwkpoli(pol_keyemp,pol_keypro,pol_keycon,pol_codacu,pol_descta,         pol_cia,pol_neg,     pol_cta,pol_scta,pol_cc,pol_icia,      pol_top,    pol_ietu,pol_impcar,     pol_impabo,     pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,pol_tipo,pol_fecmov)
select pol_keyemp,pol_keypro,pol_keycon,pol_codacu,'RECLASIFICA_CONF5' pol_descta,ws_cia pol_cia,pol_neg,pol_cta,pol_scta,pol_cc,'000' pol_icia,'0' pol_top,pol_ietu,sum(pol_impabo) pol_impcar,sum(pol_impcar) pol_impabo,pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,1 pol_tipo,pol_fecmov
from labprod.tvwkpoli
where pol_keypol = keypol
and pol_cia not in ('552','284')
and pol_cc not in ('00000024','00000000')
and pol_tipo = '2'
group by pol_keyemp, pol_keypro, pol_keycon, pol_codacu,pol_neg, pol_cta, pol_scta, pol_cc,   pol_ietu, pol_keycia, pol_keypol, pol_cveban, pol_forpag, pol_keyben, pol_comfam, pol_fecmov;
insert into labprod.tvwkpoli(pol_keyemp,pol_keypro,pol_keycon,pol_codacu,pol_descta,         pol_cia,pol_neg,     pol_cta,pol_scta,pol_cc,pol_icia,      pol_top,    pol_ietu,pol_impcar,     pol_impabo,     pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,pol_tipo,pol_fecmov)
select pol_keyemp,pol_keypro,pol_keycon,pol_codacu,'RECLASIFICA_CONF6' pol_descta,ws_cia pol_cia, pol_neg,pol_cta,'121339',pol_cc,'000' pol_icia,'0' pol_top,pol_ietu,sum(pol_impcar) pol_impcar,sum(pol_impabo) pol_impabo,pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,1 pol_tipo,pol_fecmov
from labprod.tvwkpoli
where pol_keypol = keypol
and pol_cia not in ('552','284')
and pol_cc not in ('00000024','00000000')
and pol_tipo = '2'
group by pol_keyemp, pol_keypro, pol_keycon, pol_codacu,pol_neg,  pol_cta,  pol_cc,   pol_ietu, pol_keycia, pol_keypol, pol_cveban, pol_forpag, pol_keyben, pol_comfam, pol_fecmov;
--modificacion 30/06/2020
--reclasificacion para empresa 284
insert into labprod.tvwkpoli(pol_keyemp,pol_keypro,pol_keycon,pol_codacu,pol_descta,         pol_cia,pol_neg,     pol_cta,pol_scta,pol_cc,pol_icia,      pol_top,    pol_ietu,pol_impcar,     pol_impabo,     pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,pol_tipo,pol_fecmov)
select pol_keyemp,pol_keypro,pol_keycon,pol_codacu,'RECLASIFICA_CONF7' pol_descta,ws_cia pol_cia,pol_neg,pol_cta,pol_scta,pol_cc,'000' pol_icia,'0' pol_top,pol_ietu,sum(pol_impabo) pol_impcar,sum(pol_impcar) pol_impabo,pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,1 pol_tipo,pol_fecmov
from labprod.tvwkpoli
where pol_keypol = keypol
and pol_cia = '284'
and pol_cc not in ('00000024','00000000')
group by pol_keyemp, pol_keypro, pol_keycon, pol_codacu,pol_neg,  pol_cta, pol_scta, pol_cc,   pol_ietu, pol_keycia, pol_keypol, pol_cveban, pol_forpag, pol_keyben, pol_comfam, pol_fecmov;
insert into labprod.tvwkpoli(pol_keyemp,pol_keypro,pol_keycon,pol_codacu,pol_descta,         pol_cia,pol_neg,     pol_cta,pol_scta,pol_cc,pol_icia,      pol_top,    pol_ietu,pol_impcar,     pol_impabo,     pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,pol_tipo,pol_fecmov)
select pol_keyemp,pol_keypro,pol_keycon,pol_codacu,'RECLASIFICA_CONF8' pol_descta,ws_cia pol_cia,'01' pol_neg,'485' pol_cta,pol_scta,'00816417','000' pol_icia,'0' pol_top,pol_ietu,sum(pol_impcar) pol_impcar,sum(pol_impabo) pol_impabo,pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,1 pol_tipo,pol_fecmov
from labprod.tvwkpoli
where pol_keypol = keypol
and pol_cia = '284'
and pol_cc not in ('00000024','00000000')
and pol_cta like '4%'
group by pol_keyemp, pol_keypro, pol_keycon, pol_codacu, pol_scta,   pol_ietu, pol_keycia, pol_keypol, pol_cveban, pol_forpag, pol_keyben, pol_comfam, pol_fecmov;
insert into labprod.tvwkpoli(pol_keyemp,pol_keypro,pol_keycon,pol_codacu,pol_descta,         pol_cia,pol_neg,     pol_cta,pol_scta,pol_cc,pol_icia,      pol_top,    pol_ietu,pol_impcar,     pol_impabo,     pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,pol_tipo,pol_fecmov)
select pol_keyemp,pol_keypro,pol_keycon,pol_codacu,'RECLASIFICA_CONF8' pol_descta,ws_cia pol_cia,'01' pol_neg,'515' pol_cta,pol_scta,'00816855','000' pol_icia,'0' pol_top,pol_ietu,sum(pol_impcar) pol_impcar,sum(pol_impabo) pol_impabo,pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,1 pol_tipo,pol_fecmov
from labprod.tvwkpoli
where pol_keypol = keypol
and pol_cia = '284'
and pol_cc not in ('00000024','00000000')
and pol_cta like '5%'
group by pol_keyemp, pol_keypro, pol_keycon, pol_codacu, pol_scta,   pol_ietu, pol_keycia, pol_keypol, pol_cveban, pol_forpag, pol_keyben, pol_comfam, pol_fecmov;
insert into labprod.tvwkpoli(pol_keyemp,pol_keypro,pol_keycon,pol_codacu,pol_descta,         pol_cia,pol_neg,     pol_cta,pol_scta,pol_cc,pol_icia,      pol_top,    pol_ietu,pol_impcar,     pol_impabo,     pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,pol_tipo,pol_fecmov)
select pol_keyemp,pol_keypro,pol_keycon,pol_codacu,'RECLASIFICA_CONF8' pol_descta,ws_cia pol_cia,'01' pol_neg,'615' pol_cta,pol_scta,'00816851','000' pol_icia,'0' pol_top,pol_ietu,sum(pol_impcar) pol_impcar,sum(pol_impabo) pol_impabo,pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,1 pol_tipo,pol_fecmov
from labprod.tvwkpoli
where pol_keypol = keypol
and pol_cia = '284'
and pol_cc not in ('00000024','00000000')
and pol_cta like '6%'
group by pol_keyemp, pol_keypro, pol_keycon, pol_codacu,pol_scta,  pol_ietu, pol_keycia, pol_keypol, pol_cveban, pol_forpag, pol_keyben, pol_comfam, pol_fecmov;
insert into labprod.tvwkpoli(pol_keyemp,pol_keypro,pol_keycon,pol_codacu,pol_descta,         pol_cia,pol_neg,     pol_cta,pol_scta,pol_cc,pol_icia,      pol_top,    pol_ietu,pol_impcar,     pol_impabo,     pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,pol_tipo,pol_fecmov)
select pol_keyemp,pol_keypro,pol_keycon,pol_codacu,'RECLASIFICA_CONF9' pol_descta,ws_cia pol_cia,pol_neg,pol_cta,'121339' pol_scta,pol_cc,'000' pol_icia,'0' pol_top,pol_ietu,sum(pol_impcar) pol_impcar,sum(pol_impabo) pol_impabo,pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,1 pol_tipo,pol_fecmov
from labprod.tvwkpoli
where pol_keypol = keypol
and pol_cia = '284'
and pol_cc not in ('00000024','00000000')
group by pol_keyemp, pol_keypro, pol_keycon, pol_codacu,pol_neg,  pol_cta,  pol_cc,   pol_ietu, pol_keycia, pol_keypol, pol_cveban, pol_forpag, pol_keyben, pol_comfam, pol_fecmov;
insert into labprod.tvwkpoli(pol_keyemp,pol_keypro,pol_keycon,pol_codacu,pol_descta,         pol_cia,pol_neg,     pol_cta,pol_scta,pol_cc,pol_icia,      pol_top,    pol_ietu,pol_impcar,     pol_impabo,     pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,pol_tipo,pol_fecmov)
select pol_keyemp,pol_keypro,pol_keycon,pol_codacu,'RECLASIFICA_CONF10' pol_descta,ws_cia pol_cia,'01' pol_neg,'485' pol_cta,'121339' pol_scta,'00816417' pol_cc,'000' pol_icia,'0' pol_top,pol_ietu,sum(pol_impabo) pol_impcar,sum(pol_impcar) pol_impabo,pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,1 pol_tipo,pol_fecmov
from labprod.tvwkpoli
where pol_keypol = keypol
and pol_cia = '284'
and pol_cc not in ('00000024','00000000')
and pol_cta like '4%'
group by pol_keyemp, pol_keypro, pol_keycon, pol_codacu,  pol_cta,  pol_cc,   pol_ietu, pol_keycia, pol_keypol, pol_cveban, pol_forpag, pol_keyben, pol_comfam, pol_fecmov;
insert into labprod.tvwkpoli(pol_keyemp,pol_keypro,pol_keycon,pol_codacu,pol_descta,         pol_cia,pol_neg,     pol_cta,pol_scta,pol_cc,pol_icia,      pol_top,    pol_ietu,pol_impcar,     pol_impabo,     pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,pol_tipo,pol_fecmov)
select pol_keyemp,pol_keypro,pol_keycon,pol_codacu,'RECLASIFICA_CONF10' pol_descta,ws_cia pol_cia,'01' pol_neg,'485' pol_cta,'121339' pol_scta,'00816417' pol_cc,'000' pol_icia,'0' pol_top,pol_ietu,sum(pol_impabo) pol_impcar,sum(pol_impcar) pol_impabo,pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,1 pol_tipo,pol_fecmov
from labprod.tvwkpoli
where pol_keypol = keypol
and pol_cia = '284'
and pol_cc not in ('00000024','00000000')
and pol_cta like '5%'
group by pol_keyemp, pol_keypro, pol_keycon, pol_codacu,  pol_cta,  pol_cc,   pol_ietu, pol_keycia, pol_keypol, pol_cveban, pol_forpag, pol_keyben, pol_comfam, pol_fecmov;
insert into labprod.tvwkpoli(pol_keyemp,pol_keypro,pol_keycon,pol_codacu,pol_descta,         pol_cia,pol_neg,     pol_cta,pol_scta,pol_cc,pol_icia,      pol_top,    pol_ietu,pol_impcar,     pol_impabo,     pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,pol_tipo,pol_fecmov)
select pol_keyemp,pol_keypro,pol_keycon,pol_codacu,'RECLASIFICA_CONF10' pol_descta,ws_cia pol_cia,'01' pol_neg,'615' pol_cta,'121339' pol_scta,'00816851' pol_cc,'000' pol_icia,'0' pol_top,pol_ietu,sum(pol_impabo) pol_impcar,sum(pol_impcar) pol_impabo,pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,1 pol_tipo,pol_fecmov
from labprod.tvwkpoli
where pol_keypol = keypol
and pol_cia = '284'
and pol_cc not in ('00000024','00000000')
and pol_cta like '6%'
group by pol_keyemp, pol_keypro, pol_keycon, pol_codacu,   pol_ietu, pol_keycia, pol_keypol, pol_cveban, pol_forpag, pol_keyben, pol_comfam, pol_fecmov;
end if;end;
$body$
language plpgsql
;
