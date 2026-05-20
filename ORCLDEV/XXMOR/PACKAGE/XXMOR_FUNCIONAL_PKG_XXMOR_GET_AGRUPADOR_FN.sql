create or replace  function  xxmor.xxmor_funcional_pkg_xxmor_get_agrupador_fn ( pistcanal varchar, piinidsolicitud integer ) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
lst_agrupador      varchar(15);
lin_agrup_mult     integer;
--dmap conversion comment: global temp variables moved as local temp variables
glo_document_temp text;
--dmap conversion comment: declaration boundary ends
begin
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('XXMOR', 'XXMOR_FUNCIONAL_PKG');
--dmap conversion comment: gtt declaration added
select count(1)
into strict   lin_agrup_mult
from   xxmor_cat_agrupador_mult_tab
where  agrupador_multiple = pistcanal;
lst_agrupador := null;
if lin_agrup_mult > 1 then
lst_agrupador := pistcanal;
else
select agrupador
into strict   lst_agrupador
from   xxmor_agrupador_solicitud_tab
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
;
