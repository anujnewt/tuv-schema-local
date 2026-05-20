create or replace procedure usrdrc.dercorp_poderes_pkg_delete_catalogo_poderes_pr (pinid_poder_pk numeric ,pinnum_last_updated_by numeric ,pstouterror inout numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
numocupados    numeric;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
select count(*) into strict numocupados
from pendium_otorgapoder_ep_tab
where num_podertipo = pinid_poder_pk;
if numocupados>0 then
raise exception 'catalogo_ocupado' using errcode = '50001';
else
delete from pendium_catalogo_poderes_tab
where id_poder_pk     =   pinid_poder_pk;
/* commit; */
end if;
exception
when sqlstate '50001' then
pstouterror := 0;
when others then
pstouterror := sqlerrm;end;
$body$
language plpgsql
;
