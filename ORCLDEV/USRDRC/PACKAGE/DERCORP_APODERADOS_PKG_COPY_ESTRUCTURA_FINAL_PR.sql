create or replace procedure usrdrc.dercorp_apoderados_pkg_copy_estructura_final_pr (pinidempresa numeric, pstescritura varchar, psttipopoder varchar, pstgrupoapod varchar, pstnumorden varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
lstnumorden   varchar(150);
i record;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
delete from dercorp_apoderados_tab
where  id_empresa     = pinidempresa
and    des_escritura  = pstescritura;
/*for i in (select apowk.*
from dercorp_apoderados_wk_tab apowk
where apowk.id_empresa = pinidempresa
and not exists (select apo.*
from dercorp_apoderados_tab apo
where apo.id_empresa = apowk.id_empresa
and   apo.id_catalogo = apowk.id_catalogo
and   apo.id_catalogo_valor = apowk.id_catalogo_valor
and   trim(apo.des_grupo)= trim(apowk.des_grupo)
and   trim(apo.des_escritura) = trim(apowk.des_escritura)))*/
--jjaq proceso para la agrupacion de apoderados de acuerdo al numero capturado por el ususario
update dercorp_apoderados_wk_tab
set atributo2 =  pstnumorden
where 1 = 1
and	id_empresa      = pinidempresa
and num_tipo_poder  = psttipopoder
and des_escritura   = pstescritura
and trim(both atributo3) = pstgrupoapod;/* dmap converted statement start */
/*
select atributo2 into lstnumorden
from dercorp_apoderados_wk_tab apo
where 1 = 1
and	apo.id_empresa      = pinidempresa
and apo.num_tipo_poder  = psttipopoder
and apo.des_escritura   = pstescritura
and apo.des_grupo       = pstgrupoapod
and rownum              = 1;*/
update dercorp_apoderados_wk_tab
set des_grupo =   concat(pstnumorden, ' ', pstgrupoapod
) where 1 = 1
and	id_empresa      = pinidempresa
and num_tipo_poder  = psttipopoder
and des_escritura   = pstescritura
and trim(both atributo3)       = pstgrupoapod;/* dmap converted statement end */
for i in (select * from dercorp_apoderados_wk_tab apo
where id_empresa = pinidempresa
and    des_escritura  = pstescritura)
loop insert into dercorp_apoderados_tab ( id_empresa,
id_catalogo,
id_catalogo_valor,
des_tipo_elemento,
num_tipo_poder,
des_grupo,
des_escritura,
fec_fecha_baja,
des_tipo_baja,
des_documento,
cod_revocado,
des_proto_med_esc,
fec_proto_med_esc,
des_revocado_mediante,
fec_revocado_mediante,
id_revocacion,
atributo1,
atributo2,
atributo3,
atributo15,
fec_creation_date
)
values (pinidempresa,
i.id_catalogo,
i.id_catalogo_valor,
i.des_tipo_elemento,
i.num_tipo_poder,
i.des_grupo,
i.des_escritura,
i.fec_fecha_baja,
i.des_tipo_baja,
i.des_documento,
i.cod_revocado,
i.des_proto_med_esc,
i.fec_proto_med_esc,
i.des_revocado_mediante,
i.fec_revocado_mediante,
i.id_revocacion,
i.atributo1,
i.atributo2,
i.atributo3,
i.atributo15,
i.fec_creation_date
);
end loop;
/* commit; */
end;
--jjaq
$body$
language plpgsql
;
