create or replace  function  xxmor.xxlmk_ordlmk_pkg_xxmor_get_agrupador_fn ( pistcanal varchar, piinidsolicitud integer ) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
lst_agrupador      varchar(15);
lin_agrup_mult     integer;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
select count(1)
into strict   lin_agrup_mult
from   xxmor_cat_agrupador_mult_tab
where  agrupador_multiple = pistcanal;
lst_agrupador := null;
if lin_agrup_mult > 1 then
lst_agrupador := pistcanal;
else
select distinct agrupador
into strict   lst_agrupador
from   xxlmk_agrupador_solicitud_tab
where  id_solicitud = piinidsolicitud
and    not exists (select 1
from   xxmor_cat_agrupador_mult_tab
where  agrupador_multiple = agrupador
having count(agrupador_multiple) > 1
);
end if;
return lst_agrupador;
exception
when no_data_found then
return null;
when others then
return null;end;
$body$
language plpgsql
stable;
