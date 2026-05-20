create or replace procedure usrdrc.dercorp_esc_sema_pkg_get_semaforo_stat_fn (pinidempresa numeric, pinidflex numeric, pstidmetarow numeric, pourlsema inout varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
lstsemastat  varchar(100):= null;
lstreqprto   varchar(100);
lstinsrppc   varchar(100);
lrcdmetainfo dercorp_metatbl_tab%rowtype;
lsturlsemast varchar(100);
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
if (pinidflex = 17 or
pinidflex = 18) then
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
lstsemastat := 'semaforo_green.png';
perform dbms_output.put_line(lstsemastat);
perform dbms_output.put_line(lrcdmetainfo.val_c6);
--semaforo en rojo
if (lrcdmetainfo.val_c4 = 'Si' or
lrcdmetainfo.val_c5 = 'Si')then     --algun check activado
--      lstsemastat := rojo;
lstsemastat := 'semaforo_red.png';
end if;
perform dbms_output.put_line(lstsemastat);
--semforo amarillo
if (nullif(lrcdmetainfo.val_c6::text, '') is not null and  --enviada
nullif(lrcdmetainfo.val_c7::text, '') is not null and  --fecha de envio
nullif(lrcdmetainfo.val_c18::text, '') is null) then    --rpc
lstsemastat := 'semaforo_yellow.png';
end if;
perform dbms_output.put_line(lstsemastat);
--semforo verde
--no requiere protocolizacion, no requiere inscripcin rpc
if (lrcdmetainfo.val_c4 = 'No' and    --req prot
lrcdmetainfo.val_c5 = 'No')then   --req rpc
if (nullif(lrcdmetainfo.val_c6::text, '') is not null and  --enviada
nullif(lrcdmetainfo.val_c7::text, '') is not null ) then --fecha envio
lstsemastat := 'semaforo_green.png';
end if;
end if;
perform dbms_output.put_line(lstsemastat);
--requiere protocolizacion, no requiere inscripcin rpc
if (lrcdmetainfo.val_c4 = 'Si' and    --req prot
lrcdmetainfo.val_c5 = 'No')then   --req rpc
if (--nullif(lrcdmetainfo.val_c6::text, '') is not null and  --enviada
--lrcdmetainfo.val_c7 is not null and  -- fecha envio
nullif(lrcdmetainfo.val_c8::text, '') is not null and  --escritura
lrcdmetainfo.val_c8 != 'N/A' and  --escritura
nullif(lrcdmetainfo.val_c9::text, '') is not null and  --fecha otorgamiento
nullif(lrcdmetainfo.val_c10::text, '') is not null and --licenciado
nullif(lrcdmetainfo.val_c11::text, '') is not null and --notario
nullif(lrcdmetainfo.val_c12::text, '') is not null --and --de
--lrcdmetainfo.val_c14 is not null
) then --fecha de firma
lstsemastat := 'semaforo_green.png';
end if;
end if;
perform dbms_output.put_line(lstsemastat);
--no requiere protocolizacion, requiere inscripcin rpc
if (lrcdmetainfo.val_c4 = 'No' and    --req prot
lrcdmetainfo.val_c5 = 'Si')then   --req rpc
if (--nullif(lrcdmetainfo.val_c6::text, '') is not null and  --enviada
--lrcdmetainfo.val_c7 is not null and  -- fecha envio
nullif(lrcdmetainfo.val_c18::text, '') is not null and  --inscrita rcp de
nullif(lrcdmetainfo.val_c19::text, '') is not null and  -- fecha de registro
nullif(lrcdmetainfo.val_c20::text, '') is not null ) then --folio
lstsemastat := 'semaforo_green.png';
end if;
end if;
perform dbms_output.put_line(lstsemastat);
--requiere protocolizacion, requiere inscripcin rpc
if (lrcdmetainfo.val_c4 = 'Si' and    --req prot
lrcdmetainfo.val_c5 = 'Si')then   --req rpc
if (--nullif(lrcdmetainfo.val_c6::text, '') is not null and  --enviada
--lrcdmetainfo.val_c7 is not null and  -- fechah envio
nullif(lrcdmetainfo.val_c8::text, '') is not null and  --escritura
lrcdmetainfo.val_c8 != 'N/A' and  --escritura
nullif(lrcdmetainfo.val_c9::text, '') is not null and  --fecha otorgamiento
nullif(lrcdmetainfo.val_c10::text, '') is not null and --licenciado
nullif(lrcdmetainfo.val_c11::text, '') is not null and --notario
nullif(lrcdmetainfo.val_c12::text, '') is not null and --de
--nullif(lrcdmetainfo.val_c14::text, '') is not null and  --fecha de firma
nullif(lrcdmetainfo.val_c18::text, '') is not null and  --inscrita rcp de
nullif(lrcdmetainfo.val_c19::text, '') is not null and  -- fecha de registro
nullif(lrcdmetainfo.val_c20::text, '') is not null) then --folio
lstsemastat := 'semaforo_green.png';
end if;
end if;
perform dbms_output.put_line(lstsemastat);
update dercorp_metatbl_tab set val_c16 = lstsemastat
where  id_empresa   = pinidempresa
and    id_flex_tbl  = pinidflex
and    id_meta_row  = pstidmetarow;
--no de escritura n/a en caso de ser nullo
if(( nullif(lrcdmetainfo.val_c8::text, '') is null) or ( lrcdmetainfo.val_c8 = null) or ( lrcdmetainfo.val_c8 = '0')) then  -- escritura
update dercorp_metatbl_tab set val_c8 = 'N/A'
where  id_empresa   = pinidempresa
and    id_flex_tbl  = pinidflex
and    id_meta_row  = pstidmetarow;
end if;
pourlsema := lstsemastat;
end if;
if (pinidflex = 20 or
pinidflex = 21 or
pinidflex = 22 or
--pinidflex = 23
pinidflex = 27 or
pinidflex = 28 or
pinidflex = 29 or
pinidflex = 30 or
pinidflex = 31 or
pinidflex = 32 or
pinidflex = 33 or
pinidflex = 34 or
pinidflex = 35 or
pinidflex = 41 or
pinidflex = 37 or-- se agregan jams 09/08/2017
pinidflex = 38-- se agregan jams 09/08/2017
) then
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
lstsemastat := 'semaforo_green.png';
perform dbms_output.put_line(lstsemastat);
perform dbms_output.put_line(lrcdmetainfo.val_c83);
--semaforo en rojo
if (lrcdmetainfo.val_c81 = 'Si' or
lrcdmetainfo.val_c82 = 'Si')then
lstsemastat := 'semaforo_red.png';
end if;
perform dbms_output.put_line(lstsemastat);
--semforo verde
--se modificacion condiciones en semaforos jams 03/08/2017
--si requiere protocolizacin
if (lrcdmetainfo.val_c81 = 'Si' and lrcdmetainfo.val_c82 = 'N/A') then --requiere protocolizacin:
if((nullif(lrcdmetainfo.val_c87::text, '') is not null and lrcdmetainfo.val_c87 != 'N/A' and lrcdmetainfo.val_c87 != 'Pendiente' ) and --fecha otorgamiento
(nullif(lrcdmetainfo.val_c93::text, '') is not null) and--escritura digitalizada:
(nullif(lrcdmetainfo.val_c86::text, '') is not null and lrcdmetainfo.val_c86 != 'N/A' and lrcdmetainfo.val_c86 != 'Pendiente') ---escritura no:
)then
lstsemastat := 'semaforo_green.png';
end if;
end if;
--si requiere inscripcin rppc
if (lrcdmetainfo.val_c82 = 'Si' and lrcdmetainfo.val_c81 = 'No' ) then --requiere inscripcin rppc:
if((nullif(lrcdmetainfo.val_c95::text, '') is not null and lrcdmetainfo.val_c95 != 'N/A' and lrcdmetainfo.val_c95 != 'Pendiente' ) and --fecha de registro:
nullif(lrcdmetainfo.val_c96::text, '') is not null and--folio mercantil/folio mercantil electrnico:
nullif(lrcdmetainfo.val_c93::text, '') is not null--escritura digitalizada:
)then
lstsemastat := 'semaforo_green.png';
end if;
end if;
--si requiere inscripcin rppc y protocolizacin
if (lrcdmetainfo.val_c81 = 'Si' and --requiere protocolizacin:
lrcdmetainfo.val_c82 = 'Si') then  --requiere inscripcin rppc:
if((nullif(lrcdmetainfo.val_c87::text, '') is not null and lrcdmetainfo.val_c87 != 'N/A' and lrcdmetainfo.val_c87 != 'Pendiente' ) and --fecha otorgamiento
(nullif(lrcdmetainfo.val_c86::text, '') is not null and lrcdmetainfo.val_c86 != 'N/A' and lrcdmetainfo.val_c86 != 'Pendiente') and ---escritura no:
(nullif(lrcdmetainfo.val_c95::text, '') is not null and lrcdmetainfo.val_c95 != 'N/A' and lrcdmetainfo.val_c95 != 'Pendiente' ) and --fecha de registro:
nullif(lrcdmetainfo.val_c96::text, '') is not null and--folio mercantil/folio mercantil electrnico:
nullif(lrcdmetainfo.val_c93::text, '') is not null--escritura digitalizada:
)then
lstsemastat := 'semaforo_green.png';
end if;
end if;
--terminan modificaiones jams 03/08/2017
perform dbms_output.put_line(lstsemastat);
update dercorp_metatbl_tab set val_c83 = lstsemastat
where  id_empresa   = pinidempresa
and    id_flex_tbl  = pinidflex
and    id_meta_row  = pstidmetarow;
pourlsema := lstsemastat;
--fecha de registro n/a en caso de no inscribirse
if ( lrcdmetainfo.val_c82 = 'No' or lrcdmetainfo.val_c82 = 'N/A') then  -- req rpc
update dercorp_metatbl_tab set val_c95 = 'N/A'
where  id_empresa   = pinidempresa
and    id_flex_tbl  = pinidflex
and    id_meta_row  = pstidmetarow;
end if;
--fecha de registro pendiente en caso inscribirse y valores sean vacios
if ( lrcdmetainfo.val_c82 = 'Si' and ( nullif(lrcdmetainfo.val_c95::text, '') is null or lrcdmetainfo.val_c95 = null or lrcdmetainfo.val_c95 = '0' or lrcdmetainfo.val_c95 = 'N/A')) then  -- req rpc
update dercorp_metatbl_tab set val_c95 = 'Pendiente'
where  id_empresa   = pinidempresa
and    id_flex_tbl  = pinidflex
and    id_meta_row  = pstidmetarow;
end if;
--no de escritura n/a en caso de ser nulo y que check de inscripcion no este seleccionado
if((lrcdmetainfo.val_c81 = 'No' or lrcdmetainfo.val_c81 = 'N/A') and ( nullif(lrcdmetainfo.val_c86::text, '') is null or lrcdmetainfo.val_c86 = null or lrcdmetainfo.val_c86 = '0' or lrcdmetainfo.val_c86 = 'Pendiente')) then  -- escritura
update dercorp_metatbl_tab set val_c86 = 'N/A'
where  id_empresa   = pinidempresa
and    id_flex_tbl  = pinidflex
and    id_meta_row  = pstidmetarow;
end if;
end if;
--no de escritura n/a en caso de ser nullo y que el check este seleccionado
if (lrcdmetainfo.val_c81 = 'Si' and ( nullif(lrcdmetainfo.val_c86::text, '') is null or lrcdmetainfo.val_c86 = null or lrcdmetainfo.val_c86 = '0' or lrcdmetainfo.val_c86 = 'N/A')) then  -- escritura
update dercorp_metatbl_tab set val_c86 = 'Pendiente'
where  id_empresa   = pinidempresa
and    id_flex_tbl  = pinidflex
and    id_meta_row  = pstidmetarow;
end if;
--flex 23
if (pinidflex = 23) then
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
----jams
lstsemastat := 'semaforo_green.png';
perform dbms_output.put_line(lstsemastat);
perform dbms_output.put_line(lrcdmetainfo.val_c104);
--semaforo en rojo
if (lrcdmetainfo.val_c101 = 'Si' or
lrcdmetainfo.val_c102 = 'Si')then
lstsemastat := 'semaforo_red.png';
end if;
perform dbms_output.put_line(lstsemastat);
--semforo verde
--se modificacion condiciones en semaforos jams 03/08/2017
--si requiere protocolizacin
if (lrcdmetainfo.val_c101 = 'Si' and lrcdmetainfo.val_c102 = 'N/A') then --requiere protocolizacin:
if((nullif(lrcdmetainfo.val_c107::text, '') is not null and lrcdmetainfo.val_c107 != 'N/A' and lrcdmetainfo.val_c107 != 'Pendiente' ) and --fecha otorgamiento
(nullif(lrcdmetainfo.val_c113::text, '') is not null) and--escritura digitalizada:
(nullif(lrcdmetainfo.val_c106::text, '') is not null and lrcdmetainfo.val_c106 != 'N/A' and lrcdmetainfo.val_c106 != 'Pendiente') ---escritura no:
)then
lstsemastat := 'semaforo_green.png';
end if;
end if;
--si requiere inscripcin rppc
if (lrcdmetainfo.val_c102 = 'Si' and lrcdmetainfo.val_c101 = 'No' ) then --requiere inscripcin rppc:
if((nullif(lrcdmetainfo.val_c115::text, '') is not null and lrcdmetainfo.val_c115 != 'N/A' and lrcdmetainfo.val_c115 != 'Pendiente' ) and --fecha de registro:
nullif(lrcdmetainfo.val_c116::text, '') is not null and--folio mercantil/folio mercantil electrnico:
nullif(lrcdmetainfo.val_c113::text, '') is not null--escritura digitalizada:
)then
lstsemastat := 'semaforo_green.png';
end if;
end if;
--si requiere inscripcin rppc y protocolizacin
if (lrcdmetainfo.val_c101 = 'Si' and --requiere protocolizacin:
lrcdmetainfo.val_c102 = 'Si') then  --requiere inscripcin rppc:
if((nullif(lrcdmetainfo.val_c107::text, '') is not null and lrcdmetainfo.val_c107 != 'N/A' and lrcdmetainfo.val_c107 != 'Pendiente' ) and --fecha otorgamiento
(nullif(lrcdmetainfo.val_c106::text, '') is not null and lrcdmetainfo.val_c106 != 'N/A' and lrcdmetainfo.val_c106 != 'Pendiente') and ---escritura no:
(nullif(lrcdmetainfo.val_c115::text, '') is not null and lrcdmetainfo.val_c115 != 'N/A' and lrcdmetainfo.val_c115 != 'Pendiente' ) and --fecha de registro:
nullif(lrcdmetainfo.val_c116::text, '') is not null and--folio mercantil/folio mercantil electrnico:
nullif(lrcdmetainfo.val_c113::text, '') is not null--escritura digitalizada:
)then
lstsemastat := 'semaforo_green.png';
end if;
end if;
--terminan modificaiones jams 03/08/2017
perform dbms_output.put_line(lstsemastat);
update dercorp_metatbl_tab set val_c103 = lstsemastat
where  id_empresa   = pinidempresa
and    id_flex_tbl  = pinidflex
and    id_meta_row  = pstidmetarow;
pourlsema := lstsemastat;
--fecha de registro pendiente en caso inscribirse y valores sean vacios
if ( lrcdmetainfo.val_c102 = 'Si' and ( nullif(lrcdmetainfo.val_c115::text, '') is null or lrcdmetainfo.val_c115 = null or lrcdmetainfo.val_c115 = '0' or lrcdmetainfo.val_c115 = 'N/A')) then  -- req rpc
update dercorp_metatbl_tab set val_c115 = 'Pendiente'
where  id_empresa   = pinidempresa
and    id_flex_tbl  = pinidflex
and    id_meta_row  = pstidmetarow;
end if;
--fecha de registro n/a en caso de no inscribirse
if ( lrcdmetainfo.val_c102 = 'No' or lrcdmetainfo.val_c102='N/A') then  --req rpc
update dercorp_metatbl_tab set val_c115 = 'N/A'
where  id_empresa   = pinidempresa
and    id_flex_tbl  = pinidflex
and    id_meta_row  = pstidmetarow;
end if;
--no de escritura n/a en caso de ser nullo y que el check no este seleccionado
if((lrcdmetainfo.val_c101 = 'No' or lrcdmetainfo.val_c101 = 'N/A') and ( nullif(lrcdmetainfo.val_c106::text, '') is null or lrcdmetainfo.val_c106 = null or lrcdmetainfo.val_c106 = '0' or lrcdmetainfo.val_c106 = 'N/A')) then  -- escritura
--if(( nullif(lrcdmetainfo.val_c106::text, '') is null)or ( lrcdmetainfo.val_c106 = )  or ( lrcdmetainfo.val_c106 = 0)) then  -- escritura
update dercorp_metatbl_tab set val_c106 = 'N/A'
where  id_empresa   = pinidempresa
and    id_flex_tbl  = pinidflex
and    id_meta_row  = pstidmetarow;
end if;
--no de escritura n/a en caso de ser nullo y que el check este seleccionado
if (lrcdmetainfo.val_c101 = 'Si' and ( nullif(lrcdmetainfo.val_c106::text, '') is null or lrcdmetainfo.val_c106 = null or lrcdmetainfo.val_c106 = '0' or lrcdmetainfo.val_c106 = 'N/A')) then  -- escritura
--if(( nullif(lrcdmetainfo.val_c106::text, '') is null)or ( lrcdmetainfo.val_c106 = )  or ( lrcdmetainfo.val_c106 = 0)) then  -- escritura
update dercorp_metatbl_tab set val_c106 = 'Pendiente'
where  id_empresa   = pinidempresa
and    id_flex_tbl  = pinidflex
and    id_meta_row  = pstidmetarow;
end if;
end if;
call dercorp_esc_sema_pkg_get_semaforo_status_fn(pinidempresa,pinidflex,pstidmetarow,lsturlsemast);
--dercorp_esc_sema_pkg_set_asunto_pr(pinidempresa,pinidflex,pstidmetarow);
end;
$body$
language plpgsql
;
