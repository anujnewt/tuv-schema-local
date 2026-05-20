create or replace procedure usrdrc.dercorp_consulta_pkg_get_campos_con_flex_pr (empresaid numeric, subsectionid numeric, resultset inout refcursor) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
open resultset for
select c.*
,v.val_valor
from   dercorp_add_campo_tab c
left join dercorp_add_campo_valor_tab v on v.id_add_campo     = c.id_add_campo
and v.id_empresa      = empresaid
where   1=1
and     c.id_subseccion = subsectionid
and     des_tipo_campo = 'FLEXTABLE'
and     c.id_flex_tbl  in (
select  ct.id_flex_tbl
from    dercorp_add_campo_tab ct
left    join dercorp_add_campo_valor_tab cvt
on      cvt.id_add_campo = ct.id_add_campo
where   1=1
and     ct.des_tipo_campo = 'CHECKBOX_A'
and     nullif(cvt.val_valor::text, '') is not null
and     cvt.id_empresa = empresaid
)
order by  id_seccion, id_subseccion, c.id_agrupacion, (c.id_order)::numeric
;end;
$body$
language plpgsql
;
