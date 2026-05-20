create or replace procedure usrdrc.pendium_con_poderes_pkg_query_poderes_carta_poder_pr (porcrsresultado inout refcursor ,pstdesc_busqueda varchar ,pinid_empresa numeric ,pstouterror inout varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
/* dmap converted statement start */
-- package does not have global variables
--dmap conversion comment: gtt declaration added
open porcrsresultado for
select pendium_escritura_poder_tab.id_ep_pk,
pendium_escritura_poder_tab.ind_tipo_escritura,
pendium_escritura_poder_tab.fec_fecha,
pendium_escritura_poder_tab.fec_otorgamiento_instr,
pendium_otorgapoder_ep_tab.des_podertipo,
pendium_otorgapoder_ep_tab.fec_vigenciafin,
pendium_otorgapoder_ep_tab.desc_apoderados,
pendium_otorgapoder_ep_tab.des_poder,
pendium_escritura_poder_tab.ind_status,
pendium_escritura_poder_tab.ind_requiere_proto,
pendium_escritura_poder_tab.ind_requiere_inscr_rppc,
pendium_escritura_poder_tab.ind_status_esc,
pendium_escritura_poder_tab.ind_status_rppc,
pendium_escritura_poder_tab.des_escritura
from pendium_escritura_poder_tab
inner join pendium_otorgapoder_ep_tab
on pendium_escritura_poder_tab.id_ep_pk              = pendium_otorgapoder_ep_tab.id_ep_fk
where pendium_escritura_poder_tab.ind_tipo_escritura = 'CP'
and pendium_escritura_poder_tab.ind_status           = 1
and pendium_escritura_poder_tab.id_empresa           = pinid_empresa
and (nullif(pstdesc_busqueda::text, '') is null or pstdesc_busqueda = null or (pendium_escritura_poder_tab.fec_fecha            = pstdesc_busqueda  or
regexp_replace(lower(pendium_otorgapoder_ep_tab.desc_apoderados),'([[:digit:]])','')      like   concat('%', lower(pstdesc_busqueda) , '%'
))
)  order by  case when nullif(pendium_escritura_poder_tab.fec_fecha::text, '') is null then to_timestamp('31/12/2999','DD/MM/YYYY') else to_timestamp(pendium_escritura_poder_tab.fec_fecha,'DD/MM/YYYY') end desc, pendium_otorgapoder_ep_tab.num_order;/* dmap converted statement end */
exception
when others then
pstouterror := sqlerrm;end;
$body$
language plpgsql
;
