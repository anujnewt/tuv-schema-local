create or replace procedure usrdrc.dercorp_consulta_pkg_get_agrupaciones_pr (sectionid numeric, subsectionid numeric, resultset inout refcursor) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
open resultset for
select
id_agrupacion,
count(*) count_campos,
case when des_tipo_campo='FLEXTABLE' then  'YES' when des_tipo_campo='AJAX_PAGE' then 'YES'  else 'NO' end  is_flex,
case(select count(*)
from dercorp_add_campo_tab
where id_seccion = c.id_seccion
and id_subseccion = c.id_subseccion
and id_agrupacion = c.id_agrupacion
and atributo2 = 'PAIR')  when 0 then 'NO' else 'YES' end is_pair
from
dercorp_add_campo_tab c
where
1=1
and
id_seccion =  sectionid
and
id_subseccion = subsectionid
group by
id_agrupacion,
case when des_tipo_campo='FLEXTABLE' then  'YES' when des_tipo_campo='AJAX_PAGE' then 'YES'  else 'NO' end ,
id_seccion,
id_subseccion
order by
c.id_agrupacion;end;
$body$
language plpgsql
;
