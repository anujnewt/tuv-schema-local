create or replace procedure usrdrc.dercorp_wk_apoderados_pkg_get_revocados_pr ( pinidempresa numeric, pintipopoder numeric, pstescritura varchar, pstleyenda inout varchar --,pstgrupo     varchar2
) as $body$
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
fec_proto_med_esc,
des_revocado_mediante,
fec_revocado_mediante,
id_revocacion
--ecm 06 mayo 2016 captura apoderados cambiar de la tabla final a la tabla de trabajo
from dercorp_apoderados_wk_tab
where id_empresa    = pinidempresa
and num_tipo_poder  = pintipopoder
--and des_grupo       = pstgrupo
and des_escritura   = pstescritura
and cod_revocado = 'Si'
group by  des_proto_med_esc,
fec_proto_med_esc,
des_revocado_mediante,
fec_revocado_mediante,
id_revocacion
order by  id_revocacion )
loop
pstleyenda :=  concat(pstleyenda, '<spam class=id_revocacion>', i.id_revocacion, '</spam>', ' Revocado mediante ', i.des_revocado_mediante , ' de fecha ', i.fec_revocado_mediante , ' Protocolizado mediante Esc. ', i.des_proto_med_esc, ' de fecha ', i.fec_proto_med_esc, '</br><hr/>') ;/* dmap converted statement end */
end loop;/* dmap converted statement start */
pstleyenda :=  concat(pstleyenda, '<br>') ;/* dmap converted statement end */end;
$body$
language plpgsql
;
