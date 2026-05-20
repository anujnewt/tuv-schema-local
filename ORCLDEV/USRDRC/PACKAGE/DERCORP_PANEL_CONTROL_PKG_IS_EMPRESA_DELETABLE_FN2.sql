create or replace  function  usrdrc.dercorp_panel_control_pkg_is_empresa_deletable_fn2 ( pinidempresa numeric) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
var_count integer;
var_id_cat_val_1 integer;
var_id_cat_val_40 integer;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
/*
select count(*) into var_count
from dercorp_metatbl_tab where id_empresa = pinidempresa;
if var_count < 5 then
return si;
end if;*/
--
-- campos de la informacion de la empresa. solo deben ser 4 (los default)
--
select count(*) into strict var_count
from dercorp_add_campo_valor_tab
where
trim(both val_valor) <> '0'
and trim(both val_valor) <> '0.00'
and upper(trim(both val_valor)) <> 'NULL'
and trim(both val_valor) <> 'semaforo_green.png'
and id_empresa = pinidempresa;
if var_count > 4 then
return 'NO1';
end if;
--
-- info en metatablas. debe ser 0
--
select count(*) into strict var_count
from dercorp_metatbl_tab where id_empresa = pinidempresa;/* dmap converted statement start */
if var_count <> 0 then
return  concat('NO2', pinidempresa) ;/* dmap converted statement end */
end if;
select
id_catalogo_valor into strict var_id_cat_val_1
from
dercorp_add_campo_cat_val_tab
where
val_cat_val in (
select nom_empresa from dercorp_empresa_tab where id_empresa = pinidempresa
)
and
id_catalogo = 1;
select
id_catalogo_valor into strict var_id_cat_val_40
from
dercorp_add_campo_cat_val_tab
where
val_cat_val in (
select nom_empresa from dercorp_empresa_tab where id_empresa = pinidempresa
)
and
id_catalogo = 40;/* dmap converted statement start */
--
-- empresas que tienen esa denominacion actual, solo debe ser una
--
select count(*) into strict var_count
from dercorp_add_campo_valor_tab where
id_add_campo = 500
and
val_valor in ( concat(var_id_cat_val_1, '')) ;/* dmap converted statement end */
if var_count > 1 then
return 'NO3';
end if;/* dmap converted statement start */
--
-- como accionista
--
select count(*)  into strict var_count
from dercorp_metatbl_tab
where
id_flex_tbl = 7
and
val_c1 in ( concat(var_id_cat_val_40, '')) ;/* dmap converted statement end */
if var_count <> 0 then
return 'NO4';
end if;/* dmap converted statement start */
--
-- en aumento de capital s.a.
--
select count(*)  into strict var_count
from dercorp_metatbl_tab
where
id_flex_tbl = 4
and ( concat(var_id_cat_val_1, '')
) in (val_c1, val_c5, val_c6, val_c8, val_c10);/* dmap converted statement end */
if var_count <> 0 then
return 'NO5';
end if;/* dmap converted statement start */
--
-- denominacion en reforma total de estatutos
--
select count(*)  into strict var_count
from dercorp_metatbl_tab
where
id_flex_tbl = 20
and ( concat(var_id_cat_val_1, '')
) in (val_c8);/* dmap converted statement end */
if var_count <> 0 then
return 'NO6';
end if;/* dmap converted statement start */
--
-- acta de hechos levantada a solicitud de en escrituras otros
--
select count(*)  into strict var_count
from dercorp_metatbl_tab
where
id_flex_tbl = 27
and ( concat(var_id_cat_val_1, '')
) in (val_c8);/* dmap converted statement end */
if var_count <> 0 then
return 'NO7';
end if;/* dmap converted statement start */
--
-- en fusion
--
select count(*) into strict var_count
from dercorp_metatbl_tab
where
id_flex_tbl = 34
and
val_c99 like  concat('%', (
var_id_cat_val_1
) , '%') ;/* dmap converted statement end */
if var_count <> 0 then
return 'NO8';
end if;/* dmap converted statement start */
--
-- en fusion
--
select count(*)  into strict var_count
from dercorp_metatbl_tab
where
id_flex_tbl = 34
and
val_c98 like  concat('%', (
var_id_cat_val_1
) , '%') ;/* dmap converted statement end */
if var_count <> 0 then
return 'NO9';
end if;/* dmap converted statement start */
--
-- contrato
--
select count(*)  into strict var_count
from dercorp_metatbl_tab
where
id_flex_tbl = 30
and
val_c11 like  concat('%', (
var_id_cat_val_1
) , '%') ;/* dmap converted statement end */
if var_count <> 0 then
return 'NO10';
end if;/* dmap converted statement start */
--
-- contrato
--
select count(*) into strict var_count
from dercorp_metatbl_tab
where
id_flex_tbl = 30
and
val_c7 like  concat('%', (
var_id_cat_val_1
) , '%') ;/* dmap converted statement end */
if var_count <> 0 then
return 'NO11';
end if;
return 'SI';/* dmap converted statement start */
exception
when others then
--rr_code := sqlcode;
--rr_msg := oracle.substr(sqlerrm, 1, 200);
return  concat('', oracle.substr(sqlerrm, 1, 200)) ;/* dmap converted statement end */end;
$body$
language plpgsql
stable;
