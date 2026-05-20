create or replace procedure usrdrc.xxtv_rep_apoderados_pkg_get_info_pr (resultset inout refcursor, paramempresas varchar, paramtipopoder varchar, paramescritura varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
/* dmap converted statement start */
-- package does not have global variables
--dmap conversion comment: gtt declaration added
open resultset for
select
distinct
names.id_empresa,
names.nom_empresa,
names.des_escritura,
names.num_tipo_poder,
names.tipo_poder,
names.des_grupo,
names.id_catalogo,
names.id_catalogo_valor id_apoderado,
names.val_cat_val nombre_apoderado,
names.des_tipo_baja,
names.des_documento,
names.fec_fecha_baja,
pod.id_catalogo,
cat_pod.nom_catalogo concepto_poder,
pod.id_catalogo_valor,
pod.val_cat_val descripcion_poder
from
dercorp_apoderados_names_vw names
inner join dercorp_apoderados_poderes_vw pod on
pod.id_empresa =      names.id_empresa
and pod.nom_empresa =     names.nom_empresa
and pod.des_escritura =   names.des_escritura
and pod.num_tipo_poder =  names.num_tipo_poder
and pod.tipo_poder =      names.tipo_poder
and pod.des_grupo =       names.des_grupo
inner join dercorp_add_campo_cat_tab cat_pod on cat_pod.id_catalogo = pod.id_catalogo
where
--names.val_cat_val like %azcarraga%
--and
( concat(',', paramempresas , ',')  like  concat('%,', names.id_empresa , ',%')
) --names.nom_empresa = televisa, s.a. de c.v.
--and
--upper(pod.val_cat_val) like %ilim%
and ( concat(',', paramtipopoder , ',')  like  concat('%,', names.num_tipo_poder , ',%')
) --and
--(replace(names.des_escritura,,,) like % || replace(paramescritura,,,) || %)
order by
names.id_empresa,
names.des_escritura,
names.num_tipo_poder,
names.des_grupo,
names.val_cat_val,
pod.id_catalogo,
pod.val_cat_val;/* dmap converted statement end */end;
$body$
language plpgsql
;
