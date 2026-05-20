create or replace procedure usrdrc.pendium_reportes_poderes_pkg_query_poderes_por_facultad_esp (porcrsresultado inout refcursor ,pstdes_empresas varchar ,pstdes_tipopoder varchar ,pstdes_apoderados varchar ,pstdes_poder varchar ,pstdes_escritura varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
dinamicquery text;
begin
/* dmap converted statement start */
-- package does not have global variables
--dmap conversion comment: gtt declaration added
dinamicquery :=  concat('SELECT PENDIUM_OTORGAPODER_EP_TAB.ID_OPODER_EP_PK, (CASE WHEN PENDIUM_ESCRITURA_PODER_TAB.IND_REQUIERE_PROTO=1 AND NULLIF(PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA::text, '') IS NOT NULL THEN PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA ELSE ''N/A'' END) DES_ESCRITURA, (CASE WHEN PENDIUM_ESCRITURA_PODER_TAB.IND_REQUIERE_PROTO=1 AND NULLIF(PENDIUM_ESCRITURA_PODER_TAB.FEC_OTORGAMIENTO_INSTR::text, '') IS NOT NULL THEN PENDIUM_ESCRITURA_PODER_TAB.FEC_OTORGAMIENTO_INSTR ELSE PENDIUM_ESCRITURA_PODER_TAB.FEC_FECHA END) as FEC_OTORGAMIENTO_INSTR, coalesce(PENDIUM_ESCRITURA_PODER_TAB.FEC_FECHA, '''') as fec_fecha, (select val_cat_val from usrdrc.dercorp_add_campo_cat_val_tab where id_catalogo = 1 and id_catalogo_valor = (select val_valor from usrdrc.dercorp_add_campo_valor_tab where id_empresa = dercorp_empresa_tab.id_empresa and id_add_campo = 500)) as nom_empresa, pendium_escritura_poder_tab.id_empresa, pendium_otorgapoder_ep_tab.des_podertipo, pendium_escritura_poder_tab.ind_tipo_escritura, coalesce(pendium_otorgapoder_ep_tab.des_poder, '''') as des_poder, coalesce(pendium_otorgapoder_ep_tab.desc_actosdominio, '''') as desc_actosdominio, coalesce(pendium_otorgapoder_ep_tab.desc_actosadmon, '''') as desc_actosadmon, coalesce(pendium_otorgapoder_ep_tab.desc_pleitoscobranza, '''') as desc_pleitoscobranza, coalesce(pendium_otorgapoder_ep_tab.desc_tituloscredito, '''') as desc_tituloscredito, pendium_escritura_poder_tab.ind_status, pendium_otorgapoder_ep_tab.desc_apoderados, pendium_otorgapoder_ep_tab.desc_descripcion, coalesce(pendium_otorgapoder_ep_tab.fec_vigenciafin, '''') as fec_vigenciafin from pendium_otorgapoder_ep_tab inner join pendium_escritura_poder_tab on pendium_escritura_poder_tab.id_ep_pk = pendium_otorgapoder_ep_tab.id_ep_fk inner join dercorp_empresa_tab on dercorp_empresa_tab.id_empresa = pendium_escritura_poder_tab.id_empresa where pendium_escritura_poder_tab.ind_status = 1 and pendium_escritura_poder_tab.des_escritura in (select distinct pendium_escritura_poder_tab.des_escritura from pendium_escritura_poder_tab where pendium_escritura_poder_tab.ind_tipo_escritura=''pg'' and pendium_escritura_poder_tab.ind_status = 1 and pendium_escritura_poder_tab.id_empresa= ', pstdes_empresas , ' )') ; /* dmap converted statement end *//* dmap converted statement start *//* dmap converted statement */
if nullif(pstdes_escritura::text, '') is not null then
dinamicquery :=  concat(dinamicquery, ' AND ( PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA LIKE ', pstdes_escritura, ' )') ;/* dmap converted statement end */
end if;/* dmap converted statement start */
if nullif(pstdes_poder::text, '') is not null then
dinamicquery :=  concat(dinamicquery, ' AND (PENDIUM_OTORGAPODER_EP_TAB.NUM_PODERTIPO       IN (', pstdes_poder, '))') ;/* dmap converted statement end */
end if;/* dmap converted statement start */
if nullif(pstdes_tipopoder::text, '') is not null then
dinamicquery :=  concat(dinamicquery, ' AND ( PENDIUM_ESCRITURA_PODER_TAB.IND_TIPO_ESCRITURA IN (', pstdes_tipopoder, '))') ;/* dmap converted statement end */
end if;/* dmap converted statement start */
if nullif(pstdes_empresas::text, '') is not null then
dinamicquery :=  concat(dinamicquery, ' AND ( DERCORP_EMPRESA_TAB.ID_EMPRESA IN (', pstdes_empresas, '))') ;/* dmap converted statement end */
end if;/* dmap converted statement start */
if nullif(pstdes_apoderados::text, '') is not null then
dinamicquery :=  concat(dinamicquery, ' AND ( ', pstdes_apoderados, ')') ;/* dmap converted statement end */
end if;/* dmap converted statement start */
dinamicquery :=  concat(dinamicquery, '  order by  nom_empresa asc,pendium_otorgapoder_ep_tab.des_podertipo asc,pendium_escritura_poder_tab.ind_tipo_escritura desc,to_date(fec_otorgamiento_instr,''dd/mm/yyyy'') desc,'
, 'PENDIUM_OTORGAPODER_EP_TAB.ID_OPODER_EP_PK,PENDIUM_OTORGAPODER_EP_TAB.NUM_ORDER ASC') ;/* dmap converted statement end */
open porcrsresultado for execute dinamicquery;end;
$body$
language plpgsql
;
