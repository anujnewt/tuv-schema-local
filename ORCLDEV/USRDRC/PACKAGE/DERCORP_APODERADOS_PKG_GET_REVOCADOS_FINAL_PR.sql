create or replace procedure usrdrc.dercorp_apoderados_pkg_get_revocados_final_pr (pinidempresa numeric, pintipopoder numeric, pstescritura varchar, pstleyenda inout varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
--lstarmaleyenda varchar(3000);
i record;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
pstleyenda := '<br>';/* dmap converted statement start */
for i in (select  des_proto_med_esc,
(select     coalesce(val_c9,'')
from       dercorp_metatbl_tab
where
val_c8 = des_proto_med_esc
and
id_empresa = pinidempresa  limit 1)as fec_proto_med_esc,
des_revocado_mediante,
fec_revocado_mediante,
id_revocacion,
atributo15
--from dercorp_apoderados_tab
--ecm 06 mayo 2016 captura apoderados cambiar de la tabla final a la tabla de trabajo
from dercorp_apoderados_tab
where id_empresa    = pinidempresa
and num_tipo_poder  = pintipopoder
--and des_grupo       = pstgrupo
and des_escritura   = pstescritura
and cod_revocado = 'Si'
group by  des_proto_med_esc,
fec_proto_med_esc,
des_revocado_mediante,
fec_revocado_mediante,
id_revocacion,
atributo15
order by  id_revocacion )
loop
if i.atributo15 = 'esc'
then
pstleyenda :=  concat(pstleyenda, '<spam class=id_revocacion>', i.id_revocacion, '</spam>', ' Revocado mediante Escritura ', i.des_proto_med_esc, ' de fecha ', i.fec_proto_med_esc, '</br><hr/>') ;/* dmap converted statement end *//* dmap converted statement start */
else if i.atributo15 = 'otro'
then
pstleyenda :=  concat(pstleyenda, '<spam class=id_revocacion>', i.id_revocacion, '</spam>', ' Revocado mediante ', i.des_revocado_mediante , ' de fecha ', i.fec_revocado_mediante , '</br><hr/>') ;/* dmap converted statement end */
end if;
end if;
/* pstleyenda := pstleyenda||<spam class=id_revocacion>||i.id_revocacion||</spam>||
revocado mediante ||i.des_revocado_mediante ||  de fecha ||
i.fec_revocado_mediante ||  protocolizado mediante esc. ||i.des_proto_med_esc||
de fecha ||i.fec_proto_med_esc||</br><hr/>;*/
end loop;/* dmap converted statement start */
pstleyenda :=  concat(pstleyenda, '<br>') ;/* dmap converted statement end */end;
$body$
language plpgsql
;
