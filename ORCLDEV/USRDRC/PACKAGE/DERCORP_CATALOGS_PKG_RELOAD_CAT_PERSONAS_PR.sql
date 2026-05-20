create or replace procedure usrdrc.dercorp_catalogs_pkg_reload_cat_personas_pr (lstdummy varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
delete from dercorp_cat_personas_tab;
insert into dercorp_cat_personas_tab
select
row_number() over () as person_id
--,person_id
,nombre
from (
select  distinct
--trim(app_common_pkg_sin_acentos_ni_nn_fn(upper(replace(replace(replace(nombre, ,_),.,),,,)))) person_id
--,
trim(both nombre) as  nombre
from    dercorp_rep_hist_func_vw
where   1=1
and     nullif(nombre::text, '') is not null
--and     app_common_pkg_sin_acentos_ni_nn_fn(upper(nombre)) like app_common_pkg_sin_acentos_ni_nn_fn(upper(%||replace(, ,%)||%))
order by  nombre
) persons;end;
$body$
language plpgsql
;
