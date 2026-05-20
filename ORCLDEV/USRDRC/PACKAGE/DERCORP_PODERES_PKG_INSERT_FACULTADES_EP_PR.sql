create or replace procedure usrdrc.dercorp_poderes_pkg_insert_facultades_ep_pr ( pinid_opoder_ep_fk numeric ,pinid_ep_fk numeric ,pinind_tipo numeric ,pstdes_tipo varchar ,pinind_delegable varchar ,pinind_individual varchar ,pstcaracteristicas varchar ,pinmancomunado numeric ,pstdes_formae varchar ,pinid_fac_ep_pk inout numeric ,pstouterror inout varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
pinnum_created_by numeric;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
select num_last_updated_by into strict pinnum_created_by from pendium_escritura_poder_tab where id_ep_pk = pinid_ep_fk;
insert into pendium_facultades_ep_tab(
id_opoder_ep_fk
,id_ep_fk
,ind_tipo
,des_tipo
,ind_delegable
,ind_individual
,caracteristicas
,mancomunado
,ind_status
,des_formae
,num_last_updated_by
,fec_last_update_date
,num_created_by
,fec_creation_date)
values (
pinid_opoder_ep_fk
,pinid_ep_fk
,pinind_tipo
,pstdes_tipo
,pinind_delegable
,pinind_individual
,pstcaracteristicas
,pinmancomunado
,1
,pstdes_formae
,pinnum_created_by
,clock_timestamp()
,pinnum_created_by
,clock_timestamp()
)
returning id_fac_ep_pk into pinid_fac_ep_pk;
exception
when others then
pstouterror := sqlerrm;end;
$body$
language plpgsql
;
