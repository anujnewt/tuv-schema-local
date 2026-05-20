create or replace  function  usrdrc.dercorp_wk_apoderados_pkg_get_credito (pinidempresa numeric, pintipopoder numeric, pstescritura varchar, pstgrupo varchar) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
lstcredito varchar(3000);
i record;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
--lstcredito := <ul type= disk>;
lstcredito := '<br>';--nava
/* dmap converted statement start */
for i in (select * from(select apo.des_grupo,
(select val_cat_val
from   dercorp_add_campo_cat_val_tab
where  id_catalogo_valor = apo.id_catalogo_valor) as credito
from  dercorp_apoderados_wk_tab apo
where apo.id_empresa      = pinidempresa
and   apo.id_catalogo     = 35
and   apo.num_tipo_poder  = pintipopoder
and   apo.des_escritura   = pstescritura
and   apo.des_grupo       = pstgrupo)tab
order by  tab.credito)
loop
lstcredito :=  concat(lstcredito, '</br><LI>', i.credito) ;/* dmap converted statement end */
end loop;/* dmap converted statement start */
--lstcredito := lstcredito||</ul>;
lstcredito :=  concat(lstcredito, '<br>') ;--nava
/* dmap converted statement end */
return lstcredito;end;
$body$
language plpgsql
stable;
