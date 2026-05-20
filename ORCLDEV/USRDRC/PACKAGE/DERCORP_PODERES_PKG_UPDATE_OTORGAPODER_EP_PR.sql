create or replace procedure usrdrc.dercorp_poderes_pkg_update_otorgapoder_ep_pr ( pinid_opoder_ep_pk numeric ,pinnum_podertipo numeric ,pstdes_podertipo varchar ,pinnum_vigenciatipo numeric ,pstdes_vigenciatipo varchar ,pinnum_vigenciatiempo numeric ,pstfec_vigenciainicio varchar ,pstfec_vigenciafin varchar ,pstdesc_caracteristicas varchar ,pstdesc_apoderados text ,pstdesc_actosdominio varchar ,pstdesc_actosadmon varchar ,pstdesc_pleitoscobranza varchar ,pstdesc_tituloscredito varchar ,pstdesc_revocados varchar ,pinnum_order numeric ,pstdesc_vigencia varchar ,pinnum_last_updated_by numeric ,pstouterror inout varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
update pendium_otorgapoder_ep_tab
set  num_podertipo        =     pinnum_podertipo
,des_podertipo        =     pstdes_podertipo
,num_vigenciatipo     =     pinnum_vigenciatipo
,des_vigenciatipo     =     pstdes_vigenciatipo
,num_vigenciatiempo   =     pinnum_vigenciatiempo
,fec_vigenciainicio   =     pstfec_vigenciainicio
,fec_vigenciafin      =     pstfec_vigenciafin
,desc_caracteristicas =     pstdesc_caracteristicas
,desc_apoderados      =     pstdesc_apoderados
,desc_actosdominio    =     pstdesc_actosdominio
,desc_actosadmon      =     pstdesc_actosadmon
,desc_pleitoscobranza =     pstdesc_pleitoscobranza
,desc_tituloscredito  =     pstdesc_tituloscredito
,desc_revocados       =     pstdesc_revocados
,num_last_updated_by  =     pinnum_last_updated_by
,fec_last_update_date =     clock_timestamp()
,num_order            =     pinnum_order
,desc_vigencia        =     pstdesc_vigencia
where  id_opoder_ep_pk      =     pinid_opoder_ep_pk;
/* commit; */
exception
when others then
pstouterror := sqlerrm;end;
$body$
language plpgsql
;
