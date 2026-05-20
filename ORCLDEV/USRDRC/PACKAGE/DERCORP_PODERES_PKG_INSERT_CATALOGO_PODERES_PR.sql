create or replace procedure usrdrc.dercorp_poderes_pkg_insert_catalogo_poderes_pr ( pstdes_podertipo varchar ,pstind_podertipo varchar ,pstdes_descripcion varchar ,pinind_tiene_ad numeric ,pstind_ad_delegable varchar ,pstind_ad_individual varchar ,pstdes_ad_formaejercerlo varchar ,pstdes_ad_caracteristicas varchar ,pstdes_actosdominio varchar ,pinind_tiene_aa numeric ,pstind_aa_delegable varchar ,pstind_aa_individual varchar ,pstdes_aa_formaejercerlo varchar ,pstdes_aa_caracteristicas varchar ,pstdes_actosadmon varchar ,pinind_tiene_tc numeric ,pstind_tc_delegable varchar ,pstind_tc_individual varchar ,pstdes_tc_formaejercerlo varchar ,pstdes_tc_caracteristicas varchar ,pstdes_titulosdecreditos varchar ,pinind_tiene_pc numeric ,pstind_pc_delegable varchar ,pstind_pc_individual varchar ,pstdes_pc_formaejercerlo varchar ,pstdes_pc_caracteristicas varchar ,pstdes_pleitoscobranzas varchar ,pstind_pe_delegable varchar ,pstind_pe_individual varchar ,pstdes_pe_formaejercerlo varchar ,pstdes_pe_caracteristicas varchar ,pstdes_facultades varchar ,pinnum_created_by numeric ,pinid_poder_pk inout numeric ,pinid_catalogo numeric ,pstouterror inout varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
lin_num_seq numeric;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
select nextval('usrdrc.pendium_cat_pod_seq') into strict lin_num_seq
;
insert into pendium_catalogo_poderes_tab(id_poder_pk
,des_podertipo
,ind_podertipo
,des_descripcion
,ind_tiene_ad
,ind_ad_delegable
,ind_ad_individual
,des_ad_formaejercerlo
,des_ad_caracteristicas
,des_actosdominio
,ind_tiene_aa
,ind_aa_delegable
,ind_aa_individual
,des_aa_formaejercerlo
,des_aa_caracteristicas
,des_actosadmon
,ind_tiene_tc
,ind_tc_delegable
,ind_tc_individual
,des_tc_formaejercerlo
,des_tc_caracteristicas
,des_titulosdecreditos
,ind_tiene_pc
,ind_pc_delegable
,ind_pc_individual
,des_pc_formaejercerlo
,des_pc_caracteristicas
,des_pleitoscobranzas
,ind_pe_delegable
,ind_pe_individual
,des_pe_formaejercerlo
,des_pe_caracteristicas
,des_facultades
,num_created_by
,fec_creation_date
,ind_status
,id_catalogo
)
values (lin_num_seq
,pstdes_podertipo
,pstind_podertipo
,pstdes_descripcion
,pinind_tiene_ad
,pstind_ad_delegable
,pstind_ad_individual
,pstdes_ad_formaejercerlo
,pstdes_ad_caracteristicas
,pstdes_actosdominio
,pinind_tiene_aa
,pstind_aa_delegable
,pstind_aa_individual
,pstdes_aa_formaejercerlo
,pstdes_aa_caracteristicas
,pstdes_actosadmon
,pinind_tiene_tc
,pstind_tc_delegable
,pstind_tc_individual
,pstdes_tc_formaejercerlo
,pstdes_tc_caracteristicas
,pstdes_titulosdecreditos
,pinind_tiene_pc
,pstind_pc_delegable
,pstind_pc_individual
,pstdes_pc_formaejercerlo
,pstdes_pc_caracteristicas
,pstdes_pleitoscobranzas
,pstind_pe_delegable
,pstind_pe_individual
,pstdes_pe_formaejercerlo
,pstdes_pe_caracteristicas
,pstdes_facultades
,pinnum_created_by
,clock_timestamp()
,1
,pinid_catalogo
);
/* commit; */
pinid_poder_pk := lin_num_seq;
exception
when others then
pstouterror := sqlerrm;end;
$body$
language plpgsql
;
