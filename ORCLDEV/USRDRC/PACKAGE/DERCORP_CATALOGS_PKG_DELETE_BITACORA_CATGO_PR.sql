create or replace procedure usrdrc.dercorp_catalogs_pkg_delete_bitacora_catgo_pr (pstnomcatalogo varchar, pistusuario varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
linidconsecutivo  numeric;
lincount          numeric;
linregistroborrar numeric;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
select count(id_bitacora_del)into lincount
from dercorp_bita_delete_cat_tab;
if lincount = 20
then
select min(id_bitacora_del) into strict linregistroborrar
from dercorp_bita_delete_cat_tab;
delete from dercorp_bita_delete_cat_tab
where id_bitacora_del = linregistroborrar;
end if;
select  coalesce(max(id_bitacora_del) + 1,1) into strict linidconsecutivo
from dercorp_bita_delete_cat_tab;
insert into dercorp_bita_delete_cat_tab(id_bitacora_del,
nom_catalogo,
num_created_by,
fec_creation_date)
values ( linidconsecutivo,
pstnomcatalogo,
pistusuario,
clock_timestamp());end;
$body$
language plpgsql
;
