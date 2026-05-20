create or replace procedure usrdrc.dercorp_poderes_pkg_update_facultades_ep_pr (pind_fac_ep numeric ,pinind_tipo numeric ,pstdes_tipo varchar ,pinind_delegable varchar ,pinind_individual varchar ,pstcaracteristicas varchar ,pinmancomunado numeric ,pinnum_last_updated_by numeric ,pstouterror inout varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
update pendium_facultades_ep_tab
set   ind_tipo             =    pinind_tipo
,ind_delegable        =    pinind_delegable
,ind_individual       =    pinind_individual
,caracteristicas      =    pstcaracteristicas
,mancomunado          =    pinmancomunado
,num_last_updated_by  =    pinnum_last_updated_by
,fec_last_update_date =    clock_timestamp()
where id_fac_ep_pk    =       pind_fac_ep;
/* commit; */
exception when others
then
pstouterror := sqlerrm;end;
$body$
language plpgsql
;
