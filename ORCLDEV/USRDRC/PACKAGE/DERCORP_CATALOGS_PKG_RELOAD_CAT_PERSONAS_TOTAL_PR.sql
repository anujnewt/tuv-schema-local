create or replace procedure usrdrc.dercorp_catalogs_pkg_reload_cat_personas_total_pr (lstdummy varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
i record;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
for i in (
select
dercorp_catalogs_pkg_max_personas_total_fn( row_number() over ()) person_id
--,person_id
,nombre
from (
select   distinct
trim(both nombre) as  nombre
from   dercorp_cat_personas_total_vw
where  1=1
and    nullif(nombre::text, '') is not null
order by  nombre
) persons
where  not exists (select cattot.nombre
from   dercorp_cat_personas_total_tab cattot
where  cattot.nombre = persons.nombre)
)
loop
insert into dercorp_cat_personas_total_tab(person_id,nombre)
values (i.person_id,i.nombre);
end loop;
/* commit; */
end;
$body$
language plpgsql
;
