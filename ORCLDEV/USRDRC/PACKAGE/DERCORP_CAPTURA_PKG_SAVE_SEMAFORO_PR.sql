create or replace procedure usrdrc.dercorp_captura_pkg_save_semaforo_pr (param_id_empresa integer) as $body$
declare
-- pgv moved types start
-- pgv moved types end
lstsemastat  varchar(100):= null;
lstidaddcampo varchar(100):= null;
lstvvaplica  varchar(100);
lstvvcheck   varchar(100);
lstvvselect  varchar(100);
lstvvfecha   varchar(100);
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
begin
select val_valor
into strict   lstvvcheck
from   dercorp_add_campo_valor_tab
where  1=1
and    id_empresa   = param_id_empresa
and    id_add_campo  = '1160'
;
exception
when no_data_found then
lstvvcheck := null;
end;
begin
select trim(both val_valor)
into strict   lstvvselect
from   dercorp_add_campo_valor_tab
where  1=1
and    id_empresa   = param_id_empresa
and    id_add_campo  = '1162'
;
exception
when no_data_found then
lstvvselect := 0;
end;
begin
select val_valor
into strict   lstvvfecha
from   dercorp_add_campo_valor_tab
where  1=1
and    id_empresa   = param_id_empresa
and    id_add_campo  = '1163'
;
exception
when no_data_found then
lstvvfecha := null;
end;
-- aplica
begin
select val_valor
into strict   lstvvaplica
from   dercorp_add_campo_valor_tab
where  1=1
and    id_empresa   = param_id_empresa
and    id_add_campo  = '1024'
;
exception
when no_data_found then
lstvvaplica := null;
end;
lstsemastat := 'semaforo_red.png';
--escritura constitutiva
if nullif(lstvvcheck::text, '') is not null or (lstvvselect <> '0' and nullif(lstvvfecha::text, '') is not null) then
--if lstvvselect != 0 and lstvvfecha  is not null then
--if lstvvselect <> 0 then
lstsemastat := 'semaforo_green.png';
end if;
--
if nullif(lstvvaplica::text, '') is null then
lstsemastat := 'semaforo_green.png';
end if;
insert into dercorp_add_campo_valor_tab(id_add_campo,
id_empresa,
fec_creation_date)
select
da_campo.id_add_campo, param_id_empresa, clock_timestamp()
from
dercorp_add_campo_tab da_campo
where
da_campo.cod_campo = 'C1132'
and
not exists (select 1
from dercorp_add_campo_valor_tab
where
id_add_campo = 1132
and
id_empresa = param_id_empresa
)
;
update dercorp_add_campo_valor_tab
set    val_valor = lstsemastat
where  1=1
and    id_empresa   = param_id_empresa
and    id_add_campo = '1132'
;end;
$body$
language plpgsql
;
