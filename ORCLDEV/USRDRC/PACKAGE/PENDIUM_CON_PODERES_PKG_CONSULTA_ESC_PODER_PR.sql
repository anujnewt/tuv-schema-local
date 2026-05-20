create or replace procedure usrdrc.pendium_con_poderes_pkg_consulta_esc_poder_pr (porcrsresultado inout refcursor ,pinid_empresa numeric ,pstdesc_busqueda varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
/* dmap converted statement start */
-- package does not have global variables
--dmap conversion comment: gtt declaration added
open   porcrsresultado for
select  poder.des_podertipo,
(case when esc.ind_requiere_proto=1 and nullif(esc.des_escritura::text, '') is not null then
esc.des_escritura else 'N/A' end) des_escritura,
esc.id_ep_pk,
poder.num_podertipo,
(case when esc.ind_requiere_proto=1 and nullif(esc.fec_otorgamiento_instr::text, '') is not null then
esc.fec_otorgamiento_instr else esc.fec_fecha end) as fec_fecha,
esc.fec_otorgamiento_instr,
esc.ind_requiere_inscr_rppc,
esc.fec_registro,
esc.num_folio_merc,
esc.ind_requiere_proto,
esc.num_documentum_instr,
esc.num_licenciado,
esc.desc_asunto,
poder.desc_apoderados,
poder.fec_vigenciafin,
poder.desc_actosdominio,
poder.desc_pleitoscobranza,
poder.desc_actosadmon,
poder.desc_tituloscredito,
coalesce(pe.des_poder,'') as desc_poder_especial,
esc.ind_tipo_escritura,
poder.id_opoder_ep_pk,
pe.id_opoder_ep_pk as pe_id,
esc_b.ind_tipo_escritura
from pendium_otorgapoder_ep_tab poder
inner join pendium_escritura_poder_tab esc on esc.id_ep_pk = poder.id_ep_fk  and esc.ind_status = 1  and poder.ind_status = 1
left join pendium_otorgapoder_ep_tab pe
join pendium_escritura_poder_tab esc_b on (esc_b.id_ep_pk = pe.id_ep_fk and esc_b.ind_tipo_escritura = 'PE' and esc_b.ind_status = 1  and pe.ind_status = 1)
on trim(both coalesce(to_char(poder.des_poder),' ')) = coalesce(pe.des_podertipo,' ') and esc_b.id_empresa = esc.id_empresa and coalesce(esc.des_escritura,' ') = coalesce(esc_b.des_escritura,' ')
and esc.ind_delegado_por = esc_b.ind_delegado_por and coalesce(esc.fec_fecha,' ') = coalesce(esc_b.fec_fecha,' ') and coalesce(esc.num_documentum_instr,' ') = coalesce(esc_b.num_documentum_instr,' ')
and coalesce(esc.fec_otorgamiento_instr,' ') = coalesce(esc_b.fec_otorgamiento_instr,' ') and esc.num_licenciado = esc_b.num_licenciado and coalesce(esc.num_insc_regpub,' ') = coalesce(esc_b.num_insc_regpub,' ')
and coalesce(esc.fec_registro,' ') = coalesce(esc_b.fec_registro,' ')
where esc.ind_tipo_escritura = 'PG'
and esc.ind_status = 1
and esc.id_empresa = pinid_empresa
and (esc.des_escritura         like   concat('%', pstdesc_busqueda , '%'
) or   regexp_replace(lower(esc.desc_asunto),'([[:digit:]])','')     like   concat('%', lower(pstdesc_busqueda) , '%'
) or   regexp_replace(lower(poder.desc_apoderados),'([[:digit:]])','')     like   concat('%', lower(pstdesc_busqueda) , '%'
) or   esc.fec_otorgamiento_instr              = pstdesc_busqueda )
order by  case when nullif(esc.fec_fecha::text, '') is not null then to_timestamp(fec_fecha,'DD/MM/YYYY') else to_timestamp('31/12/2999','DD/MM/YYYY') end desc
,case when nullif(esc.des_escritura::text, '') is null or des_escritura='N/A' then 99999999 else (replace(esc.des_escritura,',',''))::numeric  end desc, esc.id_ep_pk, poder.num_order;/* dmap converted statement end */end;
$body$
language plpgsql
;
