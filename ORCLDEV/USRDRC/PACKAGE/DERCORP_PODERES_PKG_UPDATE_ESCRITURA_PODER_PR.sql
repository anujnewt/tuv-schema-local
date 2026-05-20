create or replace procedure usrdrc.dercorp_poderes_pkg_update_escritura_poder_pr ( pinid_ep_pk numeric ,pstind_tipo_escritura varchar ,pinnum_created_by numeric ,pinind_delegado_por numeric ,pstfec_fecha varchar ,pstfec_hora varchar ,pinind_requiere_proto numeric ,pinind_requiere_inscr_rppc numeric ,pstdes_escritura varchar ,pstnum_documentum_instr varchar ,pstfec_otorgamiento_instr varchar ,pstnum_licenciado varchar ,pstdes_suplencia_asociado varchar ,pstfec_registro varchar ,pstnum_folio_merc varchar ,pstdes_otros_datos_registro varchar ,pstind_status_esc varchar ,pstind_status_rppc varchar ,pstdesc_apoderados varchar ,pstdesc_asunto varchar ,pstdes_revoca varchar ,pinind_ok numeric ,pstfec_pe varchar ,pstind_status_ac varchar ,pinid_red_resp numeric ,pstdes_rep_resp varchar ,pstfec_rep varchar ,pinid_reg_resp numeric ,pstdes_reg_resp varchar ,pstfec_reg varchar ,pinid_cor_resp numeric ,pstdes_cor_resp varchar ,pstfec_cor varchar ,pinid_aut_resp numeric ,pstdes_aut_resp varchar ,pstfec_aut varchar ,pinid_fir_resp numeric ,pstdes_fir_resp varchar ,pstfec_fir varchar ,pinid_ent_resp numeric ,pstdes_ent_resp varchar ,pstfec_ent varchar ,pstid_sol_doc varchar ,pinid_sol_resp numeric ,pstdes_sol_resp varchar ,pstfec_sol varchar ,pstfec_sol_rec varchar ,pstdes_sol_folio varchar ,pstid_ent_doc varchar ,pstfec_ent_doc varchar ,pstfec_ent_rec varchar ,pinnum_insc_regpub varchar ,pstdes_insc_regpub varchar ,pstdes_caracteristicas varchar ,pinind_aplica_status numeric ,pstouterror inout varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
update pendium_escritura_poder_tab
set  ind_tipo_escritura      =    pstind_tipo_escritura
,ind_delegado_por        =    pinind_delegado_por
,fec_fecha               =    pstfec_fecha
,fec_hora                =    pstfec_hora
,ind_requiere_proto      =    pinind_requiere_proto
,ind_requiere_inscr_rppc =    pinind_requiere_inscr_rppc
,des_escritura           =    pstdes_escritura
,num_documentum_instr    =    pstnum_documentum_instr
,fec_otorgamiento_instr  =    pstfec_otorgamiento_instr
,num_licenciado          =    pstnum_licenciado
,des_suplencia_asociado  =    pstdes_suplencia_asociado
,fec_registro            =    pstfec_registro
,num_folio_merc          =    pstnum_folio_merc
,des_otros_datos_registro=    pstdes_otros_datos_registro
,desc_apoderados         =    pstdesc_apoderados
,desc_asunto             =    pstdesc_asunto
,ind_status_esc          =    pstind_status_esc
,ind_status_rppc         =    pstind_status_rppc
,des_revoca              =    pstdes_revoca
,ind_ok=pinind_ok
,fec_pe=pstfec_pe
,ind_status_ac=pstind_status_ac
,id_red_resp=pinid_red_resp
,des_rep_resp=pstdes_rep_resp
,fec_rep=pstfec_rep
,id_reg_resp=pinid_reg_resp
,des_reg_resp=pstdes_reg_resp
,fec_reg=pstfec_reg
,id_cor_resp=pinid_cor_resp
,des_cor_resp=pstdes_cor_resp
,fec_cor=pstfec_cor
,id_aut_resp=pinid_aut_resp
,des_aut_resp=pstdes_aut_resp
,fec_aut=pstfec_aut
,id_fir_resp=pinid_fir_resp
,des_fir_resp=pstdes_fir_resp
,fec_fir=pstfec_fir
,id_ent_resp=pinid_ent_resp
,des_ent_resp=pstdes_ent_resp
,fec_ent=pstfec_ent
,id_sol_doc=pstid_sol_doc
,id_sol_resp=pinid_sol_resp
,des_sol_resp=pstdes_sol_resp
,fec_sol=pstfec_sol
,fec_sol_rec=pstfec_sol_rec
,des_sol_folio=pstdes_sol_folio
,id_ent_doc=pstid_ent_doc
,fec_ent_doc=pstfec_ent_doc
,fec_ent_rec=pstfec_ent_rec
,num_insc_regpub=pinnum_insc_regpub
,des_insc_regpub=pstdes_insc_regpub
,des_caracteristicas = pstdes_caracteristicas
,ind_aplica_status = pinind_aplica_status
,num_last_updated_by = pinnum_created_by
,fec_last_update_date  = clock_timestamp()
where id_ep_pk                 =    pinid_ep_pk;
delete from pendium_otorgapoder_ep_tab where id_ep_fk = pinid_ep_pk;
delete from pendium_apoderado_ep_tab where id_ep_fk = pinid_ep_pk;
delete from pendium_documentums_ep_tab where id_ep_fk = pinid_ep_pk;
delete from pendium_facultades_ep_tab where id_ep_fk = pinid_ep_pk;
delete from pendium_revoca_ep_tab where id_ep_fk = pinid_ep_pk;
/* commit; */
exception when others
then
pstouterror := sqlerrm;end;
$body$
language plpgsql
;
