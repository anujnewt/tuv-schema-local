create or replace procedure usrdrc.dercorp_poderes_pkg_insert_otorgapoder_ep_pr (pinid_ep_fk numeric ,pinnum_podertipo numeric ,pstdes_podertipo varchar ,pinnum_vigenciatipo numeric ,pstdes_vigenciatipo varchar ,pinnum_vigenciatiempo numeric ,pstfec_vigenciainicio varchar ,pstfec_vigenciafin varchar ,pstdesc_caracteristicas varchar ,pstdesc_descripcion varchar ,pstdesc_apoderados text ,pstdesc_actosdominio varchar ,pstdesc_actosadmon varchar ,pstdesc_pleitoscobranza varchar ,pstdesc_tituloscredito varchar ,pstdesc_revocados varchar ,pinnum_order numeric ,pstdesc_vigencia varchar ,pstdes_poder varchar ,pinid_opoder_ep_pk inout numeric ,pstouterror inout varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
insert into pendium_otorgapoder_ep_tab(id_ep_fk
,num_podertipo
,des_podertipo
,num_vigenciatipo
,des_vigenciatipo
,num_vigenciatiempo
,fec_vigenciainicio
,fec_vigenciafin
,desc_caracteristicas
,desc_descripcion
,desc_apoderados
,desc_actosdominio
,desc_actosadmon
,desc_pleitoscobranza
,desc_tituloscredito
,desc_revocados
,desc_vigencia
,num_order
,ind_status
,des_poder)
values (pinid_ep_fk
,pinnum_podertipo
,pstdes_podertipo
,pinnum_vigenciatipo
,pstdes_vigenciatipo
,pinnum_vigenciatiempo
,pstfec_vigenciainicio
,pstfec_vigenciafin
,pstdesc_caracteristicas
,pstdesc_descripcion
,pstdesc_apoderados
,pstdesc_actosdominio
,pstdesc_actosadmon
,pstdesc_tituloscredito
,pstdesc_pleitoscobranza
,pstdesc_revocados
,pstdesc_vigencia
,pinnum_order
,1
,pstdes_poder)
returning id_opoder_ep_pk into pinid_opoder_ep_pk;
exception
when others then
pstouterror := sqlerrm;end;
$body$
language plpgsql
;
