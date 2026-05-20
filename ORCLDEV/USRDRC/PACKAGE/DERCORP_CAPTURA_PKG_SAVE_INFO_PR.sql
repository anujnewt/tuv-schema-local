create or replace procedure usrdrc.dercorp_captura_pkg_save_info_pr ( param_id_empresa integer ,param_field_code varchar ,param_field_value varchar ,pinuserid numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
var_id_catalogo numeric;
lstactvalue     varchar(2000);
lstactid        varchar(2000);
lstnewvalue     varchar(2000);
--ecm 21 julio 2015
lstsemact   varchar(2000);
lstfecmod   varchar(2000);
--ecm 27 octubre 2015
lstmensaje     varchar(2000);
lincountec     numeric;
lincounttnec   numeric;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
--icl-- 15/07/2015
--se agrega procedimiento para guardar la informacion de denominaciones anteriores cuando
--  se cambie el campo de denominacion actual
if param_field_code = 'C1' then
begin
select cv.val_valor  into strict lstactid
from   dercorp_add_campo_valor_tab cv
where  cv.id_empresa = param_id_empresa
and    cv.id_add_campo = (select ac.id_add_campo
from   dercorp_add_campo_tab ac
where  ac.cod_campo = param_field_code);
select  catv.val_cat_val  into strict  lstactvalue
from    dercorp_add_campo_cat_val_tab catv
where   catv.id_catalogo          = 1
and     catv.id_catalogo_valor    = lstactid;
select  catv.val_cat_val  into strict  lstnewvalue
from    dercorp_add_campo_cat_val_tab catv
where   catv.id_catalogo          = 1
and     catv.id_catalogo_valor    = param_field_value;
exception
when others then
lstactid:= null;
lstactvalue:= null;
lstnewvalue:= null;
end;
if lstactvalue<>lstnewvalue then
insert into dercorp_metatbl_tab(
id_meta_row,
id_flex_tbl,
id_empresa,
val_c1,
num_created_by,
fec_creation_date
)
values (
nextval('dercorp_metatbl_seq'),
2,
param_id_empresa,
lstactvalue,
pinuserid,
clock_timestamp()
);
end if;
end if;
--ecm 21 julio 2015
if param_field_code = 'C47' then
--query qe regresa el semaforo por empresa.
begin
select  val_valor
into strict    lstsemact
from    dercorp_add_campo_valor_tab
where   1=1
and     id_add_campo  = 546
and     id_empresa    = param_id_empresa
;
--obtener fechaactual
select  to_char(clock_timestamp(),'DD/MM/RRRR')
into strict    lstfecmod
where 1=1;
exception
when others then
lstsemact:= null;
end;
if lstsemact <> param_field_value then
insert into dercorp_add_campo_valor_tab(id_add_campo,
id_empresa,
num_created_by,
fec_creation_date)
select
da_campo.id_add_campo, param_id_empresa, pinuserid, clock_timestamp()
from
dercorp_add_campo_tab da_campo
where
da_campo.cod_campo = param_field_code
and
not exists (select 1
from dercorp_add_campo_valor_tab
where
id_add_campo = da_campo.id_add_campo
and
id_empresa = param_id_empresa
)
;
update  dercorp_add_campo_valor_tab
set     --val_valor = lstfecmod, --se comenta para que no actualice la fecha de tramite en estructura de capital ulr 28/02/2017
num_last_updated_by  = pinuserid,
fec_last_update_date = clock_timestamp()
where   1=1
and     id_empresa = param_id_empresa
and     id_add_campo = 1022
;
end if;
end if;
--end ecm
insert into dercorp_add_campo_valor_tab(id_add_campo,
id_empresa,
num_created_by,
fec_creation_date)
select
da_campo.id_add_campo, param_id_empresa, pinuserid, clock_timestamp()
from
dercorp_add_campo_tab da_campo
where
da_campo.cod_campo = param_field_code
and
not exists (select 1
from dercorp_add_campo_valor_tab
where
id_add_campo = da_campo.id_add_campo
and
id_empresa = param_id_empresa);
update dercorp_add_campo_valor_tab set
val_valor = param_field_value,
num_last_updated_by  = pinuserid,
fec_last_update_date = clock_timestamp()
where
id_empresa = param_id_empresa
and
id_add_campo in ( select id_add_campo
from dercorp_add_campo_tab
where
cod_campo = param_field_code);end;
$body$
language plpgsql
;
