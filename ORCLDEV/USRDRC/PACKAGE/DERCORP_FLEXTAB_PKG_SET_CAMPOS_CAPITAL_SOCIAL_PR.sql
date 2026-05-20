create or replace procedure usrdrc.dercorp_flextab_pkg_set_campos_capital_social_pr ( param_id_empresa varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
lstacf    numeric  :=0;
lstacv    numeric  :=0;
linvalnom numeric  :=0;
linreslim numeric  :=0;
linacs    numeric  :=0;
liexpresnomin numeric;
liexpresnominvalteonom numeric;
livalteonom   numeric;
liocapvar integer;
liocapfij integer;
liidvalteonom numeric;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
execute 'ALTER SESSION SET NULLIF(NLS_NUMERIC_CHARACTERS::text, '') IS NULL. ;' ; /* dmap converted statement */
--validar responsabilidad limitada----------------------------------------
select  count(*)
into strict    linreslim
from    dercorp_add_campo_valor_tab emp
inner join dercorp_add_campo_cat_val_tab cat
on      (emp.val_valor)::numeric  = (cat.id_catalogo_valor)::numeric
where   1=1
and     emp.id_empresa = param_id_empresa
and     emp.id_add_campo = 519
and     upper(cat.nom_cat_val) like '%RESPONSABILIDAD%LIMITADA%'
;
if linreslim = 0 then
select  count(*) into strict liexpresnomin
from    dercorp_add_campo_valor_tab emp
inner   join dercorp_add_campo_cat_val_tab cat
on      (emp.val_valor)::numeric  = (cat.id_catalogo_valor)::numeric
where   1=1
and     emp.id_empresa = param_id_empresa
and     emp.id_add_campo = 519
and (upper(cat.nom_cat_val) like '%SIN%EXPRES%NOMINAL'
or upper(cat.nom_cat_val) like '%VALOR%DESIGUAL%'
)
;
if liexpresnomin = 0 then
--obtener valor nominal-----------------------------------------------
begin
select
coalesce((
select  (replace(replace(val_cat_val, '$', ''), ',', ''))::numeric
from    dercorp_add_campo_cat_val_tab
where   1=1
and     id_catalogo = 9
and     id_catalogo_valor = val_valor
),0)into   linvalnom
from    dercorp_add_campo_valor_tab
where   1=1
and     id_empresa = param_id_empresa
and     id_add_campo = 519
;
exception
when no_data_found then
linvalnom := 0;
when others then
linvalnom := 0;
end;
--obtener id teorico nominal-----------------------------------------------
begin
select
coalesce((
select  (replace(replace(val_cat_val, '$', ''), ',', ''))::numeric
from    dercorp_add_campo_cat_val_tab
where   1=1
and     id_catalogo = 9
and     id_catalogo_valor = val_valor
),0)into   liidvalteonom
from    dercorp_add_campo_valor_tab
where   1=1
and     id_empresa = param_id_empresa
and     id_add_campo = 1076
;
exception
when no_data_found then
liidvalteonom := 0;
when others then
liidvalteonom := 0;
end;
if linvalnom = 0 then
linvalnom := liidvalteonom;
end if;
--obtener todas las cantidades----------------------------------------
select  sum((coalesce(val_c3,0))::numeric )*linvalnom
,sum((coalesce(val_c4,0))::numeric )*linvalnom
into strict    lstacf, lstacv
from    dercorp_metatbl_tab
where   1=1
and     id_flex_tbl = 7
and     id_empresa = param_id_empresa
;/* dmap converted statement start */
perform dbms_output.put_line( concat('Multiplicar capFijo y capVar:  ', lstacf, ' | ', lstacv)) ;/* dmap converted statement end */
call dercorp_flextab_pkg_get_check_cap_fij_var_pr(liocapvar, liocapfij, (param_id_empresa)::numeric  );
if liocapfij > 0 then
update  dercorp_add_campo_valor_tab
set     val_valor     = lstacf
where   1=1
and     id_empresa    = param_id_empresa
and     id_add_campo  = 1028
;
end if;
if liocapvar > 0 then
update  dercorp_add_campo_valor_tab
set     val_valor     = lstacv
where   1=1
and     id_empresa    = param_id_empresa
and     id_add_campo  = 1029
;
end if;
if liocapvar > 0 or liocapfij > 0 then
linacs := (lstacf + lstacv);
update  dercorp_add_campo_valor_tab
set     val_valor     = linacs
where   1=1
and     id_empresa    = param_id_empresa
and     id_add_campo  = 541
;
end if;
/* commit; */
elsif liexpresnomin > 0 then
select  count(*) into strict liexpresnominvalteonom
from    dercorp_add_campo_valor_tab emp
inner   join dercorp_add_campo_cat_val_tab cat
on      (emp.val_valor)::numeric  = (cat.id_catalogo_valor)::numeric
where   1=1
and     emp.id_empresa = param_id_empresa
and     emp.id_add_campo = 1076
and (upper(cat.nom_cat_val) like '%SIN%EXPRES%NOMINAL'
or upper(cat.nom_cat_val) like '%VALOR%DESIGUAL%'
)
;
if liexpresnominvalteonom = 0 then
--obtener valor te??rico nominal
select    (replace(replace(val_cat_val, '$', ''), ',', ''))::numeric
into strict      livalteonom
from      dercorp_add_campo_cat_val_tab
where     1=1
and       id_catalogo = 9
and       id_catalogo_valor = (
select  val_valor
from    dercorp_add_campo_valor_tab
where   1=1
and     id_add_campo = 1076
and     id_empresa = param_id_empresa
)
;
--obtener todas las cantidades----------------------------------------
select  sum((val_c3)::numeric )*livalteonom
,sum((val_c4)::numeric )*livalteonom
into strict    lstacf, lstacv
from    dercorp_metatbl_tab
where   1=1
and     id_flex_tbl = 7
and     id_empresa = param_id_empresa
;
call dercorp_flextab_pkg_get_check_cap_fij_var_pr(liocapvar, liocapfij, (param_id_empresa)::numeric  );
if liocapfij > 0 then
update  dercorp_add_campo_valor_tab
set     val_valor     = lstacf
where   1=1
and     id_empresa    = param_id_empresa
and     id_add_campo  = 1028
;
end if;
if liocapvar > 0 then
update  dercorp_add_campo_valor_tab
set     val_valor     = lstacv
where   1=1
and     id_empresa    = param_id_empresa
and     id_add_campo  = 1029
;
end if;
if liocapfij > 0 or liocapvar > 0 then
linacs := (lstacf + lstacv);
update  dercorp_add_campo_valor_tab
set     val_valor     = linacs
where   1=1
and     id_empresa    = param_id_empresa
and     id_add_campo  = 541
;
end if;
/* commit; */
elsif liexpresnominvalteonom > 0 then
select  sum((val_c3)::numeric )
,sum((val_c4)::numeric )
into strict    lstacf, lstacv
from    dercorp_metatbl_tab
where   1=1
and     id_flex_tbl = 7
and     id_empresa = param_id_empresa
;
call dercorp_flextab_pkg_get_check_cap_fij_var_pr(liocapvar, liocapfij, (param_id_empresa)::numeric  );
if liocapfij > 0 then
update  dercorp_add_campo_valor_tab
set     val_valor     = lstacf
where   1=1
and     id_empresa    = param_id_empresa
and     id_add_campo  = 1028
;
end if;
if liocapvar > 0 then
update  dercorp_add_campo_valor_tab
set     val_valor     = lstacv
where   1=1
and     id_empresa    = param_id_empresa
and     id_add_campo  = 1029
;
end if;
if liocapfij > 0 or liocapvar > 0 then
linacs := lstacf + lstacv;
update  dercorp_add_campo_valor_tab
set     val_valor     = linacs
where   1=1
and     id_empresa    = param_id_empresa
and     id_add_campo  = 541
;
end if;
/* commit; */
end if;
end if;
elsif linreslim = 1 then
--obtener las cantidades-sin valor nominal----------------------------
select  sum((val_c3)::numeric )
,sum((val_c4)::numeric )
into strict    lstacf, lstacv
from    dercorp_metatbl_tab
where   1=1
and     id_flex_tbl = 7
and     id_empresa = param_id_empresa
;/* dmap converted statement start */
perform dbms_output.put_line( concat('Sin Valor Nominal capFijo y capVar:  ', lstacf, ' | ', lstacv)) ;/* dmap converted statement end */
call dercorp_flextab_pkg_get_check_cap_fij_var_pr(liocapvar, liocapfij, (param_id_empresa)::numeric  );
if liocapfij > 0 then
update  dercorp_add_campo_valor_tab
set     val_valor     = lstacf
where   1=1
and     id_empresa    = param_id_empresa
and     id_add_campo  = 1028
;
end if;
if liocapvar > 0 then
update  dercorp_add_campo_valor_tab
set     val_valor     = lstacv
where   1=1
and     id_empresa    = param_id_empresa
and     id_add_campo  = 1029
;
end if;
if liocapfij > 0 or liocapvar > 0 then
--ecm 31 agosto 2015
linacs := lstacf + lstacv;
update  dercorp_add_campo_valor_tab
set     val_valor     = linacs
where   1=1
and     id_empresa    = param_id_empresa
and     id_add_campo  = 541
;
end if;
/* commit; */
end if;
--------------------------------------------------------------------------------
exception
when no_data_found then
perform dbms_output.put_line('NO_DATA_FOUND');end;
$body$
language plpgsql
;
