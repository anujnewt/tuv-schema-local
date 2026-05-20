create or replace  function  usrdrc.dercorp_apoderados_pkg_get_grupo_union_revocado (pinidempresa numeric, pintipopoder numeric, pstescritura varchar, pstgrupo varchar) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
cur_grupo cursor for
select distinct apo.id_empresa,
apo.des_escritura,
apo.num_tipo_poder,
apo.des_grupo,
dercorp_apoderados_pkg_get_dominio(apo.id_empresa,apo.num_tipo_poder,apo.des_escritura,apo.des_grupo) as actos_dominio,
dercorp_apoderados_pkg_get_administracion(apo.id_empresa,apo.num_tipo_poder,apo.des_escritura,apo.des_grupo) as actos_administracion,
dercorp_apoderados_pkg_get_credito(apo.id_empresa,apo.num_tipo_poder,apo.des_escritura,apo.des_grupo) as titulos_credito,
dercorp_apoderados_pkg_get_pleito(apo.id_empresa,apo.num_tipo_poder,apo.des_escritura,apo.des_grupo) as pleitos_cobranzas,
dercorp_apoderados_pkg_get_especial(apo.id_empresa,apo.num_tipo_poder,apo.des_escritura,apo.des_grupo) as poderes_especiales
from            dercorp_apoderados_tab apo
where	1=1
and	apo.id_empresa      = pinidempresa
and    apo.num_tipo_poder  = pintipopoder
and    apo.des_escritura = pstescritura
and    apo.des_grupo =  pstgrupo;
lstespecial varchar(3000):= '<br>';
lsttemp     varchar(3000);
j record;
begin
/* dmap converted statement start */
-- package does not have global variables
--dmap conversion comment: gtt declaration added
for i in cur_grupo
loop
for j in (select * from (
select distinct apo.id_empresa,
apo.des_escritura,
apo.num_tipo_poder,
apo.des_grupo,
dercorp_apoderados_pkg_get_apoderados_revocados(apo.id_empresa,apo.num_tipo_poder,apo.des_escritura,apo.des_grupo,apo.atributo3) as apoderados,
dercorp_apoderados_pkg_get_dominio(apo.id_empresa,apo.num_tipo_poder,apo.des_escritura,apo.des_grupo) as actos_dominio,
dercorp_apoderados_pkg_get_administracion(apo.id_empresa,apo.num_tipo_poder,apo.des_escritura,apo.des_grupo) as actos_administracion,
dercorp_apoderados_pkg_get_credito(apo.id_empresa,apo.num_tipo_poder,apo.des_escritura,apo.des_grupo) as titulos_credito,
dercorp_apoderados_pkg_get_pleito(apo.id_empresa,apo.num_tipo_poder,apo.des_escritura,apo.des_grupo) as pleitos_cobranzas,
dercorp_apoderados_pkg_get_especial(apo.id_empresa,apo.num_tipo_poder,apo.des_escritura,apo.des_grupo) as poderes_especiales
from            dercorp_apoderados_tab apo
where	1=1
and	apo.id_empresa         = pinidempresa
and    apo.num_tipo_poder  = pintipopoder
and    apo.des_escritura   = pstescritura) tab
where tab.actos_dominio    = i.actos_dominio
and   tab.actos_administracion = i.actos_administracion
and   tab.titulos_credito     = i.titulos_credito
and   tab.pleitos_cobranzas  =  i.pleitos_cobranzas
and   tab.poderes_especiales = i.poderes_especiales
order by  tab.apoderados )
loop
lstespecial:=  concat(lstespecial, '</br>', j.apoderados) ;/* dmap converted statement end */
end loop;
end loop;
return  lstespecial;end;
$body$
language plpgsql
stable;
