create or replace procedure usrdrc.dercorp_captura_pkg_unformat_val_campo_numeric_pr (pstempresa varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
var_val_valor   varchar(254);
dercorp_add_campo_cur cursor for
select   cv.val_valor
,cv.id_add_campo
from     dercorp_add_campo_tab        c
,dercorp_add_campo_valor_tab  cv
where    1=1
and      cv.id_add_campo = c.id_add_campo
and      c.des_tipo_campo = 'NUMERIC'
and      cv.id_empresa = pstempresa
;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
for i in dercorp_add_campo_cur
loop
var_val_valor := replace(i.val_valor, '$', ',');
var_val_valor := replace(var_val_valor, ',', '');
update  dercorp_add_campo_valor_tab
set     val_valor    = var_val_valor
where   1=1
and     id_empresa = pstempresa
and     id_add_campo = i.id_add_campo
;
end loop;end;
$body$
language plpgsql
;
