create or replace  function  usrdrc.dercorp_apoderados_pkg_get_dominio (pinidempresa numeric, pintipopoder numeric, pstescritura varchar, pstgrupo varchar) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
lstdominio varchar(3000);
i record;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
--lstdominio := <ul type= disk>;
lstdominio := '<br>'; --nava
/* dmap converted statement start */
for i in (select * from (select apo.des_grupo,
(select val_cat_val
from   dercorp_add_campo_cat_val_tab
where  id_catalogo_valor = apo.id_catalogo_valor) as dominio
from  dercorp_apoderados_tab apo
where apo.id_empresa      = pinidempresa
and   apo.id_catalogo     = 33
and   apo.num_tipo_poder  = pintipopoder
and   apo.des_escritura   = pstescritura
and   apo.des_grupo       = pstgrupo)tab
order by  tab.dominio)
loop
lstdominio :=  concat(lstdominio, '</br><LI>', i.dominio) ;/* dmap converted statement end */
end loop;/* dmap converted statement start */
--lstdominio := lstdominio||</ul>;
lstdominio :=  concat(lstdominio, '<br>') ;--nava
/* dmap converted statement end */
return lstdominio;end;
$body$
language plpgsql
stable;
