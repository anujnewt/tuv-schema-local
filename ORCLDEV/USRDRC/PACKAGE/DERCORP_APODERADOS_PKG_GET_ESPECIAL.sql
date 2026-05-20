create or replace  function  usrdrc.dercorp_apoderados_pkg_get_especial (pinidempresa numeric, pintipopoder numeric, pstescritura varchar, pstgrupo varchar) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
lstespecial varchar(3000);
i record;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
--lstespecial := <ul type= disk>;
lstespecial := '<br>';--nava
/* dmap converted statement start */
for i in (select * from(select apo.des_grupo,
(select val_cat_val
from   dercorp_add_campo_cat_val_tab
where  id_catalogo_valor = apo.id_catalogo_valor) as apoderado
from  dercorp_apoderados_tab apo
where apo.id_empresa      = pinidempresa
and   apo.id_catalogo     = 37
and   apo.num_tipo_poder  = pintipopoder
and   apo.des_escritura   = pstescritura
and   apo.des_grupo       = pstgrupo)tab
order by  tab.apoderado)
loop
lstespecial :=  concat(lstespecial, '</br><LI>', i.apoderado) ;/* dmap converted statement end */
end loop;/* dmap converted statement start */
--lstespecial := lstespecial||</ul>;
lstespecial :=  concat(lstespecial, '<br>') ; --nava
/* dmap converted statement end */
return lstespecial;end;
$body$
language plpgsql
stable;
