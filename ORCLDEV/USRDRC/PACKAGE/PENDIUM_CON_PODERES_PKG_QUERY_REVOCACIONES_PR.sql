create or replace procedure usrdrc.pendium_con_poderes_pkg_query_revocaciones_pr (porcrsresultado inout refcursor ,pstdesc_busqueda varchar ,pinid_empresa numeric ,pstouterror inout varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
/* dmap converted statement start */
-- package does not have global variables
--dmap conversion comment: gtt declaration added
open porcrsresultado for
select        pendium_escritura_poder_tab.id_ep_pk,
pendium_escritura_poder_tab.ind_tipo_escritura,
(case when pendium_escritura_poder_tab.ind_requiere_proto=1 and nullif(pendium_escritura_poder_tab.fec_otorgamiento_instr::text, '') is not null then
pendium_escritura_poder_tab.fec_otorgamiento_instr else pendium_escritura_poder_tab.fec_fecha end) fec_fecha,
(case when ind_requiere_proto=1 and nullif(des_escritura::text, '') is not null then
des_escritura else 'N/A' end) des_escritura,
(select val_cat_val from dercorp_add_campo_cat_val_tab
where id_catalogo_valor=pendium_escritura_poder_tab.ind_delegado_por) delegado_por,
pendium_escritura_poder_tab.fec_otorgamiento_instr,
pendium_escritura_poder_tab.ind_status,
pendium_escritura_poder_tab.ind_requiere_proto,
pendium_escritura_poder_tab.num_documentum_instr,
pendium_escritura_poder_tab.num_licenciado,
pendium_escritura_poder_tab.ind_requiere_inscr_rppc,
pendium_escritura_poder_tab.fec_registro,
pendium_escritura_poder_tab.num_folio_merc,
pendium_escritura_poder_tab.ind_status_esc,
pendium_escritura_poder_tab.ind_status_rppc
from pendium_escritura_poder_tab
where pendium_escritura_poder_tab.ind_tipo_escritura = 'ER'
and pendium_escritura_poder_tab.ind_status           = 1
and pendium_escritura_poder_tab.id_empresa           = pinid_empresa
and (nullif(pstdesc_busqueda::text, '') is null or pstdesc_busqueda = null or (des_escritura  like   concat('%', pstdesc_busqueda , '%'
) or (case when pendium_escritura_poder_tab.ind_requiere_proto=1 and nullif(pendium_escritura_poder_tab.fec_otorgamiento_instr::text, '') is not null then
pendium_escritura_poder_tab.fec_otorgamiento_instr else pendium_escritura_poder_tab.fec_fecha end) = pstdesc_busqueda))
order by  case when nullif(fec_fecha::text, '') is null then to_timestamp('31/12/2999','DD/MM/YYYY') else to_timestamp(fec_fecha,'DD/MM/YYYY') end desc,
case when nullif(des_escritura::text, '') is null or des_escritura='N/A' then 99999999 else (replace(des_escritura,',',''))::numeric  end;/* dmap converted statement end */
exception
when others then
pstouterror := sqlerrm;end;
$body$
language plpgsql
;
