create or replace  function  usrdrc.app_common_pkg_get_field_text_value (idaddcampo integer, idempresa integer) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
val varchar(1000);
begin
/* dmap converted statement start */
-- package does not have global variables
--dmap conversion comment: gtt declaration added
select /*+ index(dercorp_add_campo_tab (id_add_campo)) + index(dercorp_add_campo_valor_tab (id_add_campo)) */          coalesce(cat.val_cat_val,cv.val_valor) valor_textual into strict val
/* from
dercorp_add_campo_valor_tab cv
inner join dercorp_add_campo_tab ac on ac.id_add_campo = cv.id_add_campo
left join dercorp_add_campo_cat_val_tab cat on to_number(cat.id_catalogo) = to_number(coalesce(trim(ac.id_catalogo)::numeric, 0))
and to_char(cat.id_catalogo_valor) = cv.val_valor */
from
dercorp_add_campo_valor_tab cv
inner join dercorp_add_campo_tab ac on ac.id_add_campo = cv.id_add_campo
left join dercorp_add_campo_cat_val_tab cat on cat.id_catalogo = ac.id_catalogo
and to_char(cat.id_catalogo_valor) = cv.val_valor
where
cv.id_empresa = idempresa
and
ac.id_add_campo = idaddcampo
;/* dmap converted statement end */
return val;end;
$body$
language plpgsql
;
