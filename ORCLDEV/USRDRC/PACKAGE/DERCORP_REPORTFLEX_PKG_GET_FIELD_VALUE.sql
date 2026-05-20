create or replace  function  usrdrc.dercorp_reportflex_pkg_get_field_value (idaddcampo integer, idempresa integer) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
val varchar(255);
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
select
val_valor into strict val
from
dercorp_add_campo_valor_tab
where
id_empresa = idempresa
and
id_add_campo = idaddcampo
;
return val;end;
$body$
language plpgsql
;
