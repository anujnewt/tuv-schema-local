create or replace procedure usrdrc.dercorp_test_flash_pkg_monitor_flash_pr ( pinidempresa numeric, piniduser numeric, pistvalordenomsocial varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
linval_valor   varchar(100);
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
select val_valor into strict linval_valor
from dercorp_add_campo_valor_tab
where id_add_campo = 500
and id_empresa = pinidempresa;
if linval_valor <> pistvalordenomsocial
then
begin
insert into log_flas_tab(
valor_anterior,
valor_actual,
creation_date,
nom_denominacion_actual,
nom_denominacion_anterior,
nom_modifico
)
values (
linval_valor,
pistvalordenomsocial,
clock_timestamp(),
(select val_cat_val
from dercorp_add_campo_cat_val_tab
where id_catalogo = 1
and id_catalogo_valor = pistvalordenomsocial),
(select val_cat_val
from dercorp_add_campo_cat_val_tab
where id_catalogo = 1
and id_catalogo_valor = linval_valor),
(select nom_user_long_name
from ss_user_tab
where id_user = piniduser)
);
exception
when others then
insert into log_flas_tab(valor_anterior)
values ('ERROR AL INSERTAR');
end;
end if;end;
$body$
language plpgsql
;
