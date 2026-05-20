create or replace  function  usrdrc.dercorp_wk_apoderados_pkg_get_apoderados_revocados (pinidempresa numeric, pintipopoder numeric, pstescritura varchar, pstgrupo varchar) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
lstapoderados varchar(4000):=null;
--lstapoderados varchar2;
i record;
begin
/* dmap converted statement start */
-- package does not have global variables
--dmap conversion comment: gtt declaration added
--lstapoderados := <b>||pstgrupo||</b><ul>;
lstapoderados :=  concat('<b>', pstgrupo, '</b><br><!-- X1 -->') ;  -- nava 23/feb/2016 - para quitar la sangria
/* dmap converted statement end */
for i in (select * from (select apo.des_grupo,
(select val_cat_val ||' '||case when apo.id_revocacion = 0
then ''
else '<spam class=id_revocacion>' || apo.id_revocacion || '</spam>' end --jjaq agregar id de revocacion
from   dercorp_add_campo_cat_val_tab
where  id_catalogo_valor = apo.id_catalogo_valor) as apoderado,
apo.fec_fecha_baja,
apo.des_tipo_baja,
apo.des_documento
from  dercorp_apoderados_wk_tab apo
where apo.id_empresa      = pinidempresa
and   apo.id_catalogo     = 32
and   apo.num_tipo_poder  = pintipopoder
and   apo.des_escritura   = pstescritura
and   apo.des_grupo       = pstgrupo) tab
order by  tab.apoderado)
loop
lstapoderados := lstapoderados||'</br><LI>'||i.apoderado;
/*if i.fec_fecha_baja is not null
then
lstapoderados := lstapoderados||(fec. baja:||i.fec_fecha_baja|| ,tipo baja:
||i.des_tipo_baja|| ,doc:||i.des_documento||);
end if;*/
end loop;/* dmap converted statement start */
--lstapoderados := lstapoderados||</ul>;
lstapoderados :=  concat(lstapoderados, '<br><br><!-- X2 -->') ;    -- nava 23/feb/2016 - para quitar la sangria
/* dmap converted statement end */
return lstapoderados;end;
$body$
language plpgsql
stable;
