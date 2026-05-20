create or replace procedure usrdrc.dercorp_apoderados_pkg_get_update_revocados_pr (pstfchabaja varchar, psttipobaja varchar, pstnumdocumento varchar, pstdocumentum varchar, pstcheckrevocado varchar, pstdesprotomedesc varchar, pstfecprotomedesc varchar, pstdesrevocadomediante varchar, pstfec_revocado_mediante varchar, pinidcatalogovalor numeric, pinidempresa numeric, pinidcatalogo numeric, pintipopoder numeric, pstgrupo varchar, pstescritura varchar, pstelijerev varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
linidrevocacion     numeric := 0;
linencontroigual    numeric := 0;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
--obtiene el id de revocacion
select  coalesce(max(id_revocacion) + 1,1) into strict linidrevocacion
from dercorp_apoderados_wk_tab
where id_empresa = pinidempresa
and id_catalogo = pinidcatalogo
and num_tipo_poder = pintipopoder
--and des_grupo = pstgrupo
and des_escritura = pstescritura;
if pstelijerev = 'esc'
then
select count(*) into strict linencontroigual
from dercorp_apoderados_wk_tab
where id_empresa                  = pinidempresa
and id_catalogo                   = pinidcatalogo
and num_tipo_poder                = pintipopoder
--and des_grupo                   = pstgrupo
and des_escritura                 = pstescritura
and des_proto_med_esc             = pstdesprotomedesc
and fec_proto_med_esc             = pstfecprotomedesc;
--and trim(des_revocado_mediante)   = trim(pstdesrevocadomediante)
--and fec_revocado_mediante   = pstfec_revocado_mediante;
if linencontroigual > 0
then
select distinct id_revocacion into strict linidrevocacion
from dercorp_apoderados_wk_tab
where id_empresa                  = pinidempresa
and id_catalogo                   = pinidcatalogo
and num_tipo_poder                = pintipopoder
--and des_grupo                   = pstgrupo
and des_escritura                 = pstescritura
and des_proto_med_esc             = pstdesprotomedesc
and fec_proto_med_esc             = pstfecprotomedesc;
-- and trim(des_revocado_mediante)   = trim(pstdesrevocadomediante)
-- and fec_revocado_mediante   = pstfec_revocado_mediante;
end if;
end if;
if pstelijerev = 'otro'
then
select count(*) into strict linencontroigual
from dercorp_apoderados_wk_tab
where id_empresa                  = pinidempresa
and id_catalogo                   = pinidcatalogo
and num_tipo_poder                = pintipopoder
--and des_grupo                   = pstgrupo
and des_escritura                 = pstescritura
--and des_proto_med_esc             = pstdesprotomedesc
--and fec_proto_med_esc             = pstfecprotomedesc
and trim(both des_revocado_mediante)   = trim(both pstdesrevocadomediante)
and fec_revocado_mediante   = pstfec_revocado_mediante;
if linencontroigual > 0
then
select distinct id_revocacion into strict linidrevocacion
from dercorp_apoderados_wk_tab
where id_empresa                  = pinidempresa
and id_catalogo                   = pinidcatalogo
and num_tipo_poder                = pintipopoder
--and des_grupo                   = pstgrupo
and des_escritura                 = pstescritura
--and des_proto_med_esc             = pstdesprotomedesc
--and fec_proto_med_esc             = pstfecprotomedesc
and trim(both des_revocado_mediante)   = trim(both pstdesrevocadomediante)
and fec_revocado_mediante   = pstfec_revocado_mediante;
end if;
end if;
if pstcheckrevocado = 'No'
then
linidrevocacion := null;
end if;
update dercorp_apoderados_wk_tab
set     fec_fecha_baja          = pstfchabaja,
des_tipo_baja           = psttipobaja,
des_documento           = pstnumdocumento,
atributo1               = pstdocumentum,
cod_revocado            = pstcheckrevocado,
des_proto_med_esc       = pstdesprotomedesc,
fec_proto_med_esc       = pstfecprotomedesc,
des_revocado_mediante   = trim(both pstdesrevocadomediante),
fec_revocado_mediante   = pstfec_revocado_mediante,
id_revocacion           = linidrevocacion,
atributo15              = pstelijerev
where id_catalogo_valor         = pinidcatalogovalor
and   id_empresa                = pinidempresa
and   id_catalogo               = pinidcatalogo
and   num_tipo_poder            = pintipopoder
and   atributo3                 = pstgrupo
and   des_escritura             = pstescritura
;end;
$body$
language plpgsql
;
