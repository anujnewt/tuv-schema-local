create or replace procedure usrdrc.dercorp_poderes_pkg_query_poderes_especiales_pr (porcrsresultado inout refcursor ,pstdesc_busqueda varchar ,pinid_empresa numeric ,pstouterror inout varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
/* dmap converted statement start */
-- package does not have global variables
--dmap conversion comment: gtt declaration added
open porcrsresultado for
select pendium_escritura_poder_tab.id_ep_pk as id_ep_pk,
pendium_escritura_poder_tab.ind_tipo_escritura as ind_tipo_escritura,
pendium_escritura_poder_tab.fec_fecha as fec_fecha,
pendium_otorgapoder_ep_tab.des_podertipo as des_podertipo,
pendium_otorgapoder_ep_tab.fec_vigenciafin as fec_vigenciafin,
pendium_otorgapoder_ep_tab.desc_apoderados as desc_apoderados,
pendium_otorgapoder_ep_tab.des_poder as des_poder,
pendium_escritura_poder_tab.ind_status as ind_status,
pendium_escritura_poder_tab.ind_requiere_proto as ind_requiere_proto,
pendium_escritura_poder_tab.ind_status_esc as ind_status_esc,
pendium_escritura_poder_tab.ind_status_rppc as ind_status_rppc,
pendium_escritura_poder_tab.des_escritura as des_escritura,
pendium_escritura_poder_tab.ind_requiere_inscr_rppc,
pendium_escritura_poder_tab.fec_registro,
pendium_escritura_poder_tab.num_folio_merc,
pendium_escritura_poder_tab.num_documentum_instr,
pendium_escritura_poder_tab.fec_otorgamiento_instr,
pendium_escritura_poder_tab.num_licenciado
from pendium_escritura_poder_tab
inner join pendium_otorgapoder_ep_tab
on pendium_escritura_poder_tab.id_ep_pk              = pendium_otorgapoder_ep_tab.id_ep_fk
where pendium_escritura_poder_tab.ind_tipo_escritura = 'PE'
and pendium_escritura_poder_tab.ind_status           = 1
and pendium_escritura_poder_tab.id_empresa           = pinid_empresa
and (nullif(pstdesc_busqueda::text, '') is null or pstdesc_busqueda = null or (pendium_escritura_poder_tab.des_escritura             like   concat('%', pstdesc_busqueda , '%'
) or regexp_replace(lower(pendium_otorgapoder_ep_tab.desc_apoderados),'([[:digit:]])','')     like   concat('%', lower(pstdesc_busqueda) , '%'))
)  order by  pendium_escritura_poder_tab.fec_fecha desc;/* dmap converted statement end */
exception
when others then
pstouterror := sqlerrm;end;
$body$
language plpgsql
;
