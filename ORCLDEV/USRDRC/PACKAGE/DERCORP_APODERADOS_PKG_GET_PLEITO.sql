create or replace  function  usrdrc.dercorp_apoderados_pkg_get_pleito (pinidempresa numeric, pintipopoder numeric, pstescritura varchar, pstgrupo varchar) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
lstpleito varchar(3000);
i record;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
--lstpleito := <ul type= disk>;
lstpleito := '<br>'; --nava
/* dmap converted statement start */
for i in (select * from (select apo.des_grupo,
(select val_cat_val
from   dercorp_add_campo_cat_val_tab
where  id_catalogo_valor = apo.id_catalogo_valor) as pleito
from  dercorp_apoderados_tab apo
where apo.id_empresa      = pinidempresa
and   apo.id_catalogo     = 36
and   apo.num_tipo_poder  = pintipopoder
and   apo.des_escritura   = pstescritura
and   apo.des_grupo       = pstgrupo)tab
order by  tab.pleito)
loop
lstpleito :=  concat(lstpleito, '</br><LI>', i.pleito) ;/* dmap converted statement end */
end loop;/* dmap converted statement start */
--lstpleito := lstpleito||</ul>;
lstpleito :=  concat(lstpleito, '<br>') ; --nava
/* dmap converted statement end */
return lstpleito;end;
$body$
language plpgsql
stable;
