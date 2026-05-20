create or replace procedure usrdrc.xxtv_ten_casc_pkg_quitar_padre_hijos_pr () as $body$
declare
-- pgv moved types start
-- pgv moved types end
pistcountidparent numeric;
id_parent_cur cursor for
select distinct id_parent
from app_temp_log
where nullif(id_parent::text, '') is not null
order by id_parent;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
for i in id_parent_cur
loop
select count(*) into strict pistcountidparent
from app_temp_log
where id_row = i.id_parent;
if pistcountidparent = 0
then
delete from app_temp_log tmp where tmp.id_parent = i.id_parent;
/* commit; */
end if;
end loop;end;
$body$
language plpgsql
;
