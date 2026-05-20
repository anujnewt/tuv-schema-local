create or replace  function  usrdrc.dercorp_reportflex_pkg_get_field_text_value (idaddcampo integer, idempresa integer) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
val varchar(255);
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
select
--cv.id_add_campo,
coalesce(cat.val_cat_val,cv.val_valor) into strict val
from
dercorp_add_campo_valor_tab cv
inner join dercorp_add_campo_tab ac on ac.id_add_campo = cv.id_add_campo
left join dercorp_add_campo_cat_val_tab cat on (cat.id_catalogo)::numeric  = (coalesce(trim(both ac.id_catalogo),'0'))::numeric
and to_char(cat.id_catalogo_valor) = cv.val_valor
where
cv.id_empresa = idempresa
and
cv.id_add_campo = idaddcampo
;
return val;end;
$body$
language plpgsql
;
