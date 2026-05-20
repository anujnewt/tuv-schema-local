create or replace procedure usrdrc.dercorp_captura_pkg_save_moneda_pr ( param_id_empresa integer) as $body$
declare
-- pgv moved types start
-- pgv moved types end
lsval_valor varchar(2000);
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
--se comenta para que ya no se actualize la moneda en escritura constitutiva.
/*      select  val_valor
into    lsval_valor
from    dercorp_add_campo_valor_tab
where   1=1
and     id_add_campo = 520
and     id_empresa = param_id_empresa
;
insert into dercorp_add_campo_valor_tab(id_add_campo, id_empresa, val_valor)
select  id_add_campo
,param_id_empresa
,lsval_valor
from    dercorp_add_campo_tab cam
where   1=1
and     cod_campo = c65
and not exists(
select  val_valor
from    dercorp_add_campo_valor_tab
where   1=1
and     id_add_campo = cam.id_add_campo
and     id_empresa = param_id_empresa
)
;
update dercorp_add_campo_valor_tab
set    val_valor = lsval_valor
where  1=1
and    id_add_campo in ( select  id_add_campo
from    dercorp_add_campo_tab
where   1=1
and     cod_campo = c65
);
insert into dercorp_add_campo_valor_tab(id_add_campo, id_empresa, val_valor)
select  id_add_campo
,param_id_empresa
,lsval_valor
from    dercorp_add_campo_tab cam
where   1=1
and     cod_campo = c1051
and not exists(
select  val_valor
from    dercorp_add_campo_valor_tab
where   1=1
and     id_add_campo = cam.id_add_campo
and     id_empresa = param_id_empresa
)
;
update dercorp_add_campo_valor_tab
set    val_valor = lsval_valor
where  1=1
and    id_add_campo in ( select  id_add_campo
from    dercorp_add_campo_tab
where   1=1
and     cod_campo = c1051
);
*/
null;
exception
when others then
null;end;
$body$
language plpgsql
;
