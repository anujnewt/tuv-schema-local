create or replace procedure usrdrc.pendium_reportes_poderes_pkg_query_escrituras (porcrsresultado inout refcursor ,pstdes_empresas varchar ,pstdes_tipopoder varchar ,pstdes_apoderados varchar ,pstdes_poder varchar ,pstdes_escritura varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
dinamicquery text;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
dinamicquery := 'SELECT PENDIUM_OTORGAPODER_EP_TAB.ID_OPODER_EP_PK, (CASE WHEN PENDIUM_ESCRITURA_PODER_TAB.IND_REQUIERE_PROTO=1 AND NULLIF(PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA::text, '') IS NOT NULL THEN PENDIUM_ESCRITURA_PODER_TAB.DES_ESCRITURA ELSE ''N/A'' END) DES_ESCRITURA, (CASE WHEN PENDIUM_ESCRITURA_PODER_TAB.IND_REQUIERE_PROTO=1 AND NULLIF(PENDIUM_ESCRITURA_PODER_TAB.FEC_OTORGAMIENTO_INSTR::text, '') IS NOT NULL THEN PENDIUM_ESCRITURA_PODER_TAB.FEC_OTORGAMIENTO_INSTR ELSE PENDIUM_ESCRITURA_PODER_TAB.FEC_FECHA END) as FEC_OTORGAMIENTO_INSTR, (SELECT val_cat_val FROM usrdrc.dercorp_add_campo_cat_val_tab WHERE id_catalogo = 1 AND id_catalogo_valor = (SELECT val_valor FROM usrdrc.dercorp_add_campo_valor_tab WHERE id_empresa = DERCORP_EMPRESA_TAB.ID_EMPRESA AND id_add_campo = 500)) AS NOM_EMPRESA, DEL.NOM_CAT_VAL AS DELEGADOPOR, PENDIUM_ESCRITURA_PODER_TAB.FEC_FECHA, PENDIUM_ESCRITURA_PODER_TAB.FEC_HORA, PENDIUM_ESCRITURA_PODER_TAB.NUM_DOCUMENTUM_INSTR, PENDIUM_OTORGAPODER_EP_TAB.DES_PODERTIPO, PENDIUM_ESCRITURA_PODER_TAB.IND_TIPO_ESCRITURA, coalesce(PENDIUM_OTORGAPODER_EP_TAB.DES_PODER, '''') as des_poder, coalesce(pendium_otorgapoder_ep_tab.desc_actosdominio, '''') as desc_actosdominio, coalesce(pendium_otorgapoder_ep_tab.desc_actosadmon, '''') as desc_actosadmon, coalesce(pendium_otorgapoder_ep_tab.desc_pleitoscobranza, '''') as desc_pleitoscobranza, coalesce(pendium_otorgapoder_ep_tab.desc_tituloscredito, '''') as desc_tituloscredito, pendium_escritura_poder_tab.ind_status, pendium_otorgapoder_ep_tab.desc_apoderados, pendium_otorgapoder_ep_tab.desc_descripcion from pendium_otorgapoder_ep_tab inner join pendium_escritura_poder_tab on pendium_escritura_poder_tab.id_ep_pk = pendium_otorgapoder_ep_tab.id_ep_fk inner join dercorp_empresa_tab on dercorp_empresa_tab.id_empresa = pendium_escritura_poder_tab.id_empresa left join dercorp_add_campo_cat_val_tab del on del.id_catalogo_valor = pendium_escritura_poder_tab.ind_delegado_por where pendium_otorgapoder_ep_tab.id_opoder_ep_pk not in (select pendium_otorgapoder_ep_tab.id_opoder_ep_pk from pendium_otorgapoder_ep_tab inner join pendium_otorgapoder_ep_tab pendium_otorgapoder_ep_tab1 on pendium_otorgapoder_ep_tab.des_podertipo = trim(both to_char(pendium_otorgapoder_ep_tab1.des_poder)) inner join pendium_escritura_poder_tab on pendium_escritura_poder_tab.id_ep_pk = pendium_otorgapoder_ep_tab.id_ep_fk inner join pendium_escritura_poder_tab pendium_escritura_poder_tab1 on pendium_escritura_poder_tab1.id_ep_pk = pendium_otorgapoder_ep_tab1.id_ep_fk and pendium_escritura_poder_tab1.id_empresa = pendium_escritura_poder_tab.id_empresa where pendium_escritura_poder_tab1.des_escritura = pendium_escritura_poder_tab.des_escritura and pendium_escritura_poder_tab1.ind_status = 1 and pendium_escritura_poder_tab.ind_status = 1 and pendium_escritura_poder_tab.ind_tipo_escritura = ''pe'' and pendium_escritura_poder_tab1.ind_tipo_escritura = ''pg'') and pendium_escritura_poder_tab.ind_status = 1 and nullif(pendium_escritura_poder_tab.des_escritura::text, '') is not null'; /* dmap converted statement start *//* dmap converted statement */
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
dinamicquery :=  concat(dinamicquery, '  ORDER BY  DES_ESCRITURA, NOM_EMPRESA ASC,PENDIUM_ESCRITURA_PODER_TAB.IND_TIPO_ESCRITURA DESC,'
, 'PENDIUM_OTORGAPODER_EP_TAB.ID_OPODER_EP_PK, PENDIUM_OTORGAPODER_EP_TAB.NUM_ORDER ASC') ;/* dmap converted statement end */
open porcrsresultado for execute dinamicquery;end;
$body$
language plpgsql
;
