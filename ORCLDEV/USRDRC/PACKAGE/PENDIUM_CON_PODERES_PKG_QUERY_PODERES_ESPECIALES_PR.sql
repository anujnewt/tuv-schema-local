create or replace procedure usrdrc.pendium_con_poderes_pkg_query_poderes_especiales_pr (porcrsresultado inout refcursor ,pstdesc_busqueda varchar ,pinid_empresa numeric ,pstouterror inout varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
/* dmap converted statement start */
-- package does not have global variables
--dmap conversion comment: gtt declaration added
open porcrsresultado for
select *
from (
select pendium_escritura_poder_tab.id_ep_pk,
(case when pendium_escritura_poder_tab.ind_requiere_proto=1 and nullif(pendium_escritura_poder_tab.des_escritura::text, '') is not null then
pendium_escritura_poder_tab.des_escritura else 'N/A' end) des_escritura,
pendium_escritura_poder_tab.ind_tipo_escritura,
(case when pendium_escritura_poder_tab.ind_requiere_proto=1 and nullif(pendium_escritura_poder_tab.fec_otorgamiento_instr::text, '') is not null then
pendium_escritura_poder_tab.fec_otorgamiento_instr else pendium_escritura_poder_tab.fec_fecha end) as fec_fecha,
pendium_escritura_poder_tab.fec_otorgamiento_instr,
pendium_otorgapoder_ep_tab.des_podertipo,
pendium_otorgapoder_ep_tab.fec_vigenciafin,
pendium_otorgapoder_ep_tab.desc_apoderados,
pendium_otorgapoder_ep_tab.des_poder,
pendium_escritura_poder_tab.ind_status,
pendium_escritura_poder_tab.fec_registro,
pendium_escritura_poder_tab.num_folio_merc,
pendium_escritura_poder_tab.ind_requiere_proto,
pendium_escritura_poder_tab.num_documentum_instr,
pendium_escritura_poder_tab.ind_requiere_inscr_rppc,
pendium_escritura_poder_tab.ind_status_esc,
pendium_escritura_poder_tab.num_licenciado,
pendium_escritura_poder_tab.ind_status_rppc,
pendium_otorgapoder_ep_tab.num_order
from pendium_escritura_poder_tab
inner join pendium_otorgapoder_ep_tab
on pendium_escritura_poder_tab.id_ep_pk              = pendium_otorgapoder_ep_tab.id_ep_fk
where pendium_escritura_poder_tab.ind_tipo_escritura = 'PE'
and pendium_escritura_poder_tab.ind_status           = 1
and pendium_escritura_poder_tab.id_empresa           = pinid_empresa
and pendium_escritura_poder_tab.des_escritura not in ( select eb.des_escritura
from pendium_escritura_poder_tab eb inner join pendium_otorgapoder_ep_tab pod
on eb.id_ep_pk = pod.id_ep_fk
where eb.des_escritura = pendium_escritura_poder_tab.des_escritura
and to_char(pod.des_poder) = pendium_otorgapoder_ep_tab.des_podertipo
and eb.ind_delegado_por = pendium_escritura_poder_tab.ind_delegado_por and coalesce(eb.fec_fecha,' ') = coalesce(pendium_escritura_poder_tab.fec_fecha,' ') and coalesce(eb.num_documentum_instr,' ') = coalesce(pendium_escritura_poder_tab.num_documentum_instr,' ')
and coalesce(eb.fec_otorgamiento_instr,' ') = coalesce(pendium_escritura_poder_tab.fec_otorgamiento_instr,' ') and eb.num_licenciado = pendium_escritura_poder_tab.num_licenciado and coalesce(eb.num_insc_regpub,' ') = coalesce(pendium_escritura_poder_tab.num_insc_regpub,' ')
and coalesce(eb.fec_registro,' ') = coalesce(pendium_escritura_poder_tab.fec_registro,' ')
and eb.ind_tipo_escritura = 'PG'
and eb.ind_status = 1
and eb.id_empresa = pendium_escritura_poder_tab.id_empresa)
/*union all
select pendium_escritura_poder_tab.id_ep_pk,
(case when pendium_escritura_poder_tab.ind_requiere_proto=1 and pendium_escritura_poder_tab.des_escritura is not null then
pendium_escritura_poder_tab.des_escritura else n/a end) des_escritura,
pendium_escritura_poder_tab.ind_tipo_escritura,
(case when pendium_escritura_poder_tab.ind_requiere_proto=1 and pendium_escritura_poder_tab.fec_otorgamiento_instr is not null then
pendium_escritura_poder_tab.fec_otorgamiento_instr else pendium_escritura_poder_tab.fec_fecha end) as fec_fecha,
pendium_otorgapoder_ep_tab.des_podertipo,
pendium_otorgapoder_ep_tab.fec_vigenciafin,
pendium_otorgapoder_ep_tab.desc_apoderados,
pendium_otorgapoder_ep_tab.des_poder,
pendium_escritura_poder_tab.ind_status,
pendium_escritura_poder_tab.fec_registro,
pendium_escritura_poder_tab.num_folio_merc,
pendium_escritura_poder_tab.ind_requiere_proto,
pendium_escritura_poder_tab.num_documentum_instr,
pendium_escritura_poder_tab.ind_requiere_inscr_rppc,
pendium_escritura_poder_tab.ind_status_esc,
pendium_escritura_poder_tab.num_licenciado,
pendium_escritura_poder_tab.ind_status_rppc,
pendium_otorgapoder_ep_tab.num_order
from pendium_escritura_poder_tab
inner join pendium_otorgapoder_ep_tab
on pendium_escritura_poder_tab.id_ep_pk              = pendium_otorgapoder_ep_tab.id_ep_fk
where pendium_escritura_poder_tab.ind_tipo_escritura = pe
and pendium_escritura_poder_tab.ind_status           = 1
and pendium_escritura_poder_tab.id_empresa           = pinid_empresa
and pendium_escritura_poder_tab.des_escritura =  (select distinct eb.des_escritura
from pendium_escritura_poder_tab eb
where eb.des_escritura = pendium_escritura_poder_tab.des_escritura
and eb.ind_tipo_escritura = pg
and eb.ind_status=1
and eb.id_empresa           = pendium_escritura_poder_tab.id_empresa)
and pendium_otorgapoder_ep_tab.des_podertipo not in (select trim(to_char(op.des_poder))
from pendium_escritura_poder_tab eb,
pendium_otorgapoder_ep_tab  op
where eb.id_ep_pk = op.id_ep_fk
and eb.des_escritura = pendium_escritura_poder_tab.des_escritura
and eb.ind_tipo_escritura = pg
and eb.ind_status=1
and eb.id_empresa           = pendium_escritura_poder_tab.id_empresa)*/
) temp
where (nullif(pstdesc_busqueda::text, '') is null or pstdesc_busqueda = null or (temp.des_escritura  like   concat('%', pstdesc_busqueda , '%'
) or regexp_replace(lower(temp.desc_apoderados),'([[:digit:]])','')        like   concat('%', lower(pstdesc_busqueda) , '%'))
) or temp.fec_fecha = pstdesc_busqueda
order by  case when nullif(temp.fec_fecha::text, '') is null then to_timestamp('31/12/2999','DD/MM/YYYY') else to_timestamp(temp.fec_fecha,'DD/MM/YYYY') end desc
, case when nullif(temp.des_escritura::text, '') is null or des_escritura='N/A' then 99999999 else (replace(temp.des_escritura,',',''))::numeric  end desc, temp.id_ep_pk, temp.num_order;/* dmap converted statement end */
exception
when others then
pstouterror := sqlerrm;end;
$body$
language plpgsql
;
