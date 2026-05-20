create or replace  function  usrdrc.dercorp_catalogs_pkg_get_funcionarios_fn (piinidcatalogovalor varchar) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
lstnombrefuncionario varchar(2000):= null;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
begin
select app_common_pkg_sin_acentos_fn(upper(val_cat_val))
into strict   lstnombrefuncionario
from   dercorp_add_campo_cat_val_tab
where  1=1
and    id_catalogo = 10
and    id_catalogo_valor = piinidcatalogovalor
;
if nullif(lstnombrefuncionario::text, '') is null then
lstnombrefuncionario := 'N/A';
end if;
exception
when no_data_found then
lstnombrefuncionario := 'N/A';
when others then
lstnombrefuncionario := 'N/A';
end;
return lstnombrefuncionario;end;
$body$
language plpgsql
stable;
