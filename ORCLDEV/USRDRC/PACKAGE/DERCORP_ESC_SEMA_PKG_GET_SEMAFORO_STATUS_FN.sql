create or replace procedure usrdrc.dercorp_esc_sema_pkg_get_semaforo_status_fn (pinidempresa numeric, pinidflex numeric, pstidmetarow numeric, pourlsema inout varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
lstsemastat  varchar(100):= null;
lstreqprto   varchar(100);
lstinsrppc   varchar(100);
lrcdmetainfo dercorp_metatbl_tab%rowtype;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
begin
select * into strict lrcdmetainfo
from   dercorp_metatbl_tab
where  id_empresa   = pinidempresa
and    id_flex_tbl  = pinidflex
and    id_meta_row  = pstidmetarow;
exception
when others then
lrcdmetainfo:= null;
end;
lstsemastat := 'semaforo_red.png';
--poderes generales
if (pinidflex = 17) then
--aplica / no aplica status
if (lrcdmetainfo.val_c76 = 'No')then
lstsemastat := 'semaforo_green.png';
end if;
--semaforo en verde
if (lrcdmetainfo.val_c72 = 'Si' or
--lrcdmetainfo.val_c54 is not null and
lrcdmetainfo.val_c73 <> '0'  and
nullif(lrcdmetainfo.val_c74::text, '') is not null)then
lstsemastat := 'semaforo_green.png';
end if;
update dercorp_metatbl_tab set val_c150 = lstsemastat
where  id_empresa   = pinidempresa
and    id_flex_tbl  = pinidflex
and    id_meta_row  = pstidmetarow;
pourlsema := lstsemastat;
/*
if lrcdmetainfo.val_c1 = 12342 then
update dercorp_metatbl_tab set val_c3 = null
where  id_empresa   = pinidempresa
and    id_flex_tbl  = pinidflex
and    id_meta_row  = pstidmetarow;
end if;
*/
end if;
--poderes especiales
if (pinidflex = 18) then
--aplica / no aplica status
if (lrcdmetainfo.val_c76 = 'No')then
lstsemastat := 'semaforo_green.png';
end if;
--semaforo en verde
if (lrcdmetainfo.val_c72 = 'Si' or
--lrcdmetainfo.val_c54 is not null and
lrcdmetainfo.val_c73 <> '0'  and
nullif(lrcdmetainfo.val_c74::text, '') is not null)then
lstsemastat := 'semaforo_green.png';
end if;
update dercorp_metatbl_tab set val_c150 = lstsemastat
where  id_empresa   = pinidempresa
and    id_flex_tbl  = pinidflex
and    id_meta_row  = pstidmetarow;
pourlsema := lstsemastat;
/*
if lrcdmetainfo.val_c1 = 12342 then
update dercorp_metatbl_tab set val_c3 = null
where  id_empresa   = pinidempresa
and    id_flex_tbl  = pinidflex
and    id_meta_row  = pstidmetarow;
end if;
*/
end if;
--reforma total de estatuos
if (pinidflex = 20) then
--aplica / no aplica status
if (lrcdmetainfo.val_c59 = 'No')then
lstsemastat := 'semaforo_green.png';
end if;
--semaforo en verde
if (lrcdmetainfo.val_c53 = 'Si' or
--lrcdmetainfo.val_c54 is not null and
lrcdmetainfo.val_c54 <> '0'  and
nullif(lrcdmetainfo.val_c55::text, '') is not null)then
lstsemastat := 'semaforo_green.png';
end if;
update dercorp_metatbl_tab set val_c150 = lstsemastat
where  id_empresa   = pinidempresa
and    id_flex_tbl  = pinidflex
and    id_meta_row  = pstidmetarow;
pourlsema := lstsemastat;
end if;
--reforma parcial de estatutos
if (pinidflex = 21) then
--semaforo en verde
--aplica / no aplica status
if (lrcdmetainfo.val_c49 = 'No')then
lstsemastat := 'semaforo_green.png';
end if;
if (lrcdmetainfo.val_c44 = 'Si' or
lrcdmetainfo.val_c45 <> '0' and
nullif(lrcdmetainfo.val_c46::text, '') is not null)then
lstsemastat := 'semaforo_green.png';
end if;
update dercorp_metatbl_tab set val_c150 = lstsemastat
where  id_empresa   = pinidempresa
and    id_flex_tbl  = pinidflex
and    id_meta_row  = pstidmetarow;
pourlsema := lstsemastat;
end if;
--transformacion
if (pinidflex = 22) then
--semaforo en verde
--aplica / no aplica status
if (lrcdmetainfo.val_c55 = 'No')then
lstsemastat := 'semaforo_green.png';
end if;
if (lrcdmetainfo.val_c51 = 'Si' or
lrcdmetainfo.val_c52 <> '0' and
nullif(lrcdmetainfo.val_c53::text, '') is not null)then
lstsemastat := 'semaforo_green.png';
end if;
update dercorp_metatbl_tab set val_c150 = lstsemastat
where  id_empresa   = pinidempresa
and    id_flex_tbl  = pinidflex
and    id_meta_row  = pstidmetarow;
pourlsema := lstsemastat;
end if;
--aprobacion ejercicio social
if (pinidflex = 23) then
--semaforo en verde
--aplica / no aplica status
if (lrcdmetainfo.val_c98 = 'No')then
lstsemastat := 'semaforo_green.png';
end if;
if (lrcdmetainfo.val_c83 = 'Si' or
lrcdmetainfo.val_c84 <> '0' and
nullif(lrcdmetainfo.val_c85::text, '') is not null)then
lstsemastat := 'semaforo_green.png';
end if;
update dercorp_metatbl_tab set val_c150 = lstsemastat
where  id_empresa   = pinidempresa
and    id_flex_tbl  = pinidflex
and    id_meta_row  = pstidmetarow;
pourlsema := lstsemastat;
end if;
--escrituras otros
if (pinidflex = 27) then
--semaforo en verde
--aplica / no aplica status
if (lrcdmetainfo.val_c17 = 'No')then
lstsemastat := 'semaforo_green.png';
end if;
--if(lrcdmetainfo.val_c8 is not null)then
if (lrcdmetainfo.val_c136 = 'Si' or
lrcdmetainfo.val_c137 <> '0' and
nullif(lrcdmetainfo.val_c8::text, '') is not null)then
lstsemastat := 'semaforo_green.png';
end if;
update dercorp_metatbl_tab set val_c150 = lstsemastat
where  id_empresa   = pinidempresa
and    id_flex_tbl  = pinidflex
and    id_meta_row  = pstidmetarow;
pourlsema := lstsemastat;
end if;
--acta otros
if (pinidflex = 28) then
--semaforo en verde
--aplica / no aplica status
if (lrcdmetainfo.val_c26 = 'No')then
lstsemastat := 'semaforo_green.png';
end if;
if (lrcdmetainfo.val_c136 = 'Si' or--entregada::
lrcdmetainfo.val_c137 <> '0' and--responsable:
nullif(lrcdmetainfo.val_c11::text, '') is not null)then --cumplimiento:
lstsemastat := 'semaforo_green.png';
end if;
update dercorp_metatbl_tab set val_c150 = lstsemastat
where  id_empresa   = pinidempresa
and    id_flex_tbl  = pinidflex
and    id_meta_row  = pstidmetarow;
pourlsema := lstsemastat;
end if;
--aumento de capital
if (pinidflex = 29) then
--semaforo en verde
--aplica / no aplica status
if (lrcdmetainfo.val_c45 = 'No')then
lstsemastat := 'semaforo_green.png';
end if;
if (lrcdmetainfo.val_c136 = 'Si' or
lrcdmetainfo.val_c137 <> '0' and
nullif(lrcdmetainfo.val_c23::text, '') is not null)then
lstsemastat := 'semaforo_green.png';
end if;
update dercorp_metatbl_tab set val_c150 = lstsemastat
where  id_empresa   = pinidempresa
and    id_flex_tbl  = pinidflex
and    id_meta_row  = pstidmetarow;
pourlsema := lstsemastat;
end if;
--contrato
if (pinidflex = 30) then
--semaforo en verde
--aplica / no aplica status
if (lrcdmetainfo.val_c28 = 'No')then
lstsemastat := 'semaforo_green.png';
end if;
if (lrcdmetainfo.val_c136 = 'Si' or
lrcdmetainfo.val_c137 <> '0' and
nullif(lrcdmetainfo.val_c18::text, '') is not null)then
lstsemastat := 'semaforo_green.png';
end if;
update dercorp_metatbl_tab set val_c150 = lstsemastat
where  id_empresa   = pinidempresa
and    id_flex_tbl  = pinidflex
and    id_meta_row  = pstidmetarow;
pourlsema := lstsemastat;
end if;
--decreto de dividendos
if (pinidflex = 31) then
--semaforo en verde
--aplica / no aplica status
if (lrcdmetainfo.val_c25 = 'No')then
lstsemastat := 'semaforo_green.png';
end if;
if (lrcdmetainfo.val_c136 = 'Si' or
lrcdmetainfo.val_c137 <> '0' and
nullif(lrcdmetainfo.val_c13::text, '') is not null)then
lstsemastat := 'semaforo_green.png';
end if;
update dercorp_metatbl_tab set val_c150 = lstsemastat
where  id_empresa   = pinidempresa
and    id_flex_tbl  = pinidflex
and    id_meta_row  = pstidmetarow;
pourlsema := lstsemastat;
end if;
--disminucion de capital
if (pinidflex = 32) then
--semaforo en verde
--aplica / no aplica status
if (lrcdmetainfo.val_c45 = 'No')then
lstsemastat := 'semaforo_green.png';
end if;
if (lrcdmetainfo.val_c136 = 'Si' or
lrcdmetainfo.val_c137 <> '0' and
nullif(lrcdmetainfo.val_c23::text, '') is not null)then
lstsemastat := 'semaforo_green.png';
end if;
update dercorp_metatbl_tab set val_c150 = lstsemastat
where  id_empresa   = pinidempresa
and    id_flex_tbl  = pinidflex
and    id_meta_row  = pstidmetarow;
pourlsema := lstsemastat;
end if;
--escision
if (pinidflex = 33) then
--semaforo en verde
--aplica / no aplica status
if (lrcdmetainfo.val_c47 = 'No')then
lstsemastat := 'semaforo_green.png';
end if;
if (lrcdmetainfo.val_c136 = 'Si' or
lrcdmetainfo.val_c137 <> '0' and
nullif(lrcdmetainfo.val_c25::text, '') is not null)then
lstsemastat := 'semaforo_green.png';
end if;
update dercorp_metatbl_tab set val_c150 = lstsemastat
where  id_empresa   = pinidempresa
and    id_flex_tbl  = pinidflex
and    id_meta_row  = pstidmetarow;
pourlsema := lstsemastat;
end if;
--fusion
if (pinidflex = 34) then
--semaforo en verde
--aplica / no aplica status
if (lrcdmetainfo.val_c68 = 'No')then
lstsemastat := 'semaforo_green.png';
end if;
if (lrcdmetainfo.val_c136 = 'Si' or
lrcdmetainfo.val_c137 <> '0' and
nullif(lrcdmetainfo.val_c27::text, '') is not null)then
lstsemastat := 'semaforo_green.png';
end if;
update dercorp_metatbl_tab set val_c150 = lstsemastat
where  id_empresa   = pinidempresa
and    id_flex_tbl  = pinidflex
and    id_meta_row  = pstidmetarow;
pourlsema := lstsemastat;
end if;
--sesion de consejo
if (pinidflex = 35) then
--semaforo en verde
--aplica / no aplica status
if (lrcdmetainfo.val_c25 = 'No')then
lstsemastat := 'semaforo_green.png';
end if;
if (lrcdmetainfo.val_c136 = 'Si' or
lrcdmetainfo.val_c137 <> '0' and
nullif(lrcdmetainfo.val_c12::text, '') is not null)then
lstsemastat := 'semaforo_green.png';
end if;
update dercorp_metatbl_tab set val_c150 = lstsemastat
where  id_empresa   = pinidempresa
and    id_flex_tbl  = pinidflex
and    id_meta_row  = pstidmetarow;
pourlsema := lstsemastat;
end if;
--comits
if (pinidflex = 41) then
--semaforo en verde
--aplica / no aplica status
if (lrcdmetainfo.val_c25 = 'No')then
lstsemastat := 'semaforo_green.png';
end if;
if (lrcdmetainfo.val_c136 = 'Si' or
lrcdmetainfo.val_c137 <> '0' and
nullif(lrcdmetainfo.val_c12::text, '') is not null)then
lstsemastat := 'semaforo_green.png';
end if;
update dercorp_metatbl_tab set val_c150 = lstsemastat
where  id_empresa   = pinidempresa
and    id_flex_tbl  = pinidflex
and    id_meta_row  = pstidmetarow;
pourlsema := lstsemastat;
end if;
--poder general
if (pinidflex = 17) then
--semaforo en verde
if (lrcdmetainfo.val_c72 = 'Si' or
nullif(lrcdmetainfo.val_c73::text, '') is not null and
nullif(lrcdmetainfo.val_c74::text, '') is not null)then
lstsemastat := 'semaforo_green.png';
end if;
update dercorp_metatbl_tab set val_c150 = lstsemastat
where  id_empresa   = pinidempresa
and    id_flex_tbl  = pinidflex
and    id_meta_row  = pstidmetarow;
pourlsema := lstsemastat;
end if;
--poder especial
if (pinidflex = 18) then
--semaforo en verde
if (lrcdmetainfo.val_c72 = 'Si' or
nullif(lrcdmetainfo.val_c73::text, '') is not null and
nullif(lrcdmetainfo.val_c74::text, '') is not null)then
lstsemastat := 'semaforo_green.png';
end if;
update dercorp_metatbl_tab set val_c150 = lstsemastat
where  id_empresa   = pinidempresa
and    id_flex_tbl  = pinidflex
and    id_meta_row  = pstidmetarow;
pourlsema := lstsemastat;
end if;end;
$body$
language plpgsql
;
