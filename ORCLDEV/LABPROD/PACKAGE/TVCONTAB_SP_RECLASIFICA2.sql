create or replace procedure labprod.tvcontab_sp_reclasifica2 (proceso labprod.nmlohism.his_keypro%type, periodo labprod.nmlohism.his_keyper%type,keypol labprod.tvwkpoli.pol_keypol%type) as $body$
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
--if proceso <> 533 and proceso <> 534 and proceso <> 535 or proceso <> 553 then
if dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCONTAB', 'PROCESO', 'number', 'N')::numeric not in (533,534,535,553,560) then
return;
end if;
select cia_ca3aux into strict ws_cia from labprod.nmloproc
inner join labprod.nmlocias on cia_keycia = pro_keycia
where pro_keypro = dmap_extension.f_dmap_get_pkg_var('LABPROD' , 'TVCONTAB', 'PROCESO', 'number', 'N')::numeric;
insert into labprod.tvwkpoli(pol_keyemp,pol_keypro,pol_keycon,pol_codacu,pol_descta,         pol_cia,pol_neg,     pol_cta,pol_scta,pol_cc,pol_icia,      pol_top,    pol_ietu,pol_impcar,     pol_impabo,     pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,pol_tipo,pol_fecmov)
select pol_keyemp,pol_keypro,pol_keycon,pol_codacu,'RECLASIFICA_CONF11' pol_descta,pol_cia,pol_neg,pol_cta,'121339' pol_scta,pol_cc,'000' pol_icia,'0' pol_top,pol_ietu,sum(pol_impcar) pol_impcar,sum(pol_impabo) pol_impabo,pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,1 pol_tipo,pol_fecmov
from labprod.tvwkpoli
where pol_keypol = keypol
and pol_cia = ws_cia
and pol_cc not in ('00000024','00000000')
group by pol_keyemp, pol_keypro, pol_keycon, pol_codacu, 'RECLASIFICA_CONF11', pol_cia, pol_neg, pol_cta, '121339', pol_cc, '000', '0', pol_ietu, pol_keycia, pol_keypol, pol_cveban, pol_forpag, pol_keyben, pol_comfam, 1, pol_fecmov;
insert into labprod.tvwkpoli(pol_keyemp,pol_keypro,pol_keycon,pol_codacu,pol_descta,         pol_cia,pol_neg,     pol_cta,pol_scta,pol_cc,pol_icia,      pol_top,    pol_ietu,pol_impcar,     pol_impabo,     pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,pol_tipo,pol_fecmov)
select pol_keyemp,pol_keypro,pol_keycon,pol_codacu,'RECLASIFICA_CONF12' pol_descta,pol_cia,pol_neg,pol_cta,pol_scta,pol_cc,'000' pol_icia,'0' pol_top,pol_ietu,sum(pol_impabo) pol_impcar,sum(pol_impcar) pol_impabo,pol_keycia,pol_keypol,pol_cveban,pol_forpag,pol_keyben,pol_comfam,1 pol_tipo,pol_fecmov
from labprod.tvwkpoli
where pol_keypol = keypol
and pol_cc not in ('00000024','00000000')
and pol_cia = ws_cia
and (pol_scta <> '121339')
group by pol_keyemp, pol_keypro, pol_keycon, pol_codacu, pol_cia, pol_neg, pol_cta, pol_scta, pol_cc, pol_ietu, pol_keycia, pol_keypol, pol_cveban, pol_forpag, pol_keyben, pol_comfam, pol_fecmov;end;
$body$
language plpgsql
;
