create or replace procedure usrdrc.dercorp_captura_pkg_get_moneda_pr (piin_id_empresa numeric, psto_moneda inout varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
lstmoneda varchar(256);
linmoneda numeric;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
begin
select  val_valor
into strict    lstmoneda
from    dercorp_add_campo_valor_tab
where   1=1
and     id_add_campo = 520
and     id_empresa = piin_id_empresa
;
exception
when no_data_found then
lstmoneda := null;
end;
if lstmoneda = '0' or nullif(lstmoneda::text, '') is null then
begin
select  val_valor
into strict    lstmoneda
from    dercorp_add_campo_valor_tab
where   1=1
and     id_add_campo = 1077
and     id_empresa = piin_id_empresa
;
exception
when no_data_found then
lstmoneda := null;
end;
end if;
if nullif(lstmoneda::text, '') is not null then
linmoneda := (lstmoneda)::numeric;
begin
select  val_cat_val
into strict    psto_moneda
from    dercorp_add_campo_cat_val_tab
where   1=1
and     id_catalogo = 20
and     id_catalogo_valor = linmoneda
;
exception
when no_data_found then
psto_moneda := ' ';
end;
else
psto_moneda := ' ';
end if;end;
$body$
language plpgsql
;
