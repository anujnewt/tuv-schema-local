create or replace  function  usrdrc.app_common_pkg_get_celebrado_entre_partes_fn (piinidmetarow numeric) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
pstnombre1     varchar(32000);
pstsociedades1 varchar(32000);
pstnombre2     varchar(32000);
pstsociedades2 varchar(32000);
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
begin
select  coalesce(val_c6,'0') as nombres1
into strict    pstnombre1
from    dercorp_metatbl_tab
where   1=1
and     id_meta_row = piinidmetarow
;
exception
when no_data_found then
--pstnombre1 := null;
pstnombre1 := '0';
end;
begin
select  coalesce(val_c7,'0') as sociedades1
into strict    pstsociedades1
from    dercorp_metatbl_tab
where   1=1
and     id_meta_row = piinidmetarow
;
exception
when no_data_found then
--pstsociedades1 := null;
pstsociedades1 := '0';
end;
--------------------------------------------------------------------------------
begin
select  coalesce(val_c10,'0') as nombres2
into strict    pstnombre2
from    dercorp_metatbl_tab
where   1=1
and     id_meta_row = piinidmetarow
;
exception
when no_data_found then
--pstnombre2 := null;
pstnombre2 := '0';
end;
begin
select  coalesce(val_c11,'0') as sociedades2
into strict    pstsociedades2
from    dercorp_metatbl_tab
where   1=1
and     id_meta_row = piinidmetarow
;
exception
when no_data_found then
--pstsociedades2 := null;
pstsociedades2 := '0';
end;/* dmap converted statement start */
--jjaq 11/01/2019 se comenta porque ahora quieren que se junte todos contra todos. numero 5 de la propuesta de puntos prioritarios
/*
if pstnombre1 is not null then
if pstnombre2 is not null then
return app_common_pkg_get_sociedades_accionistas_fn(pstnombre1||, ||pstnombre2, 1);
else
return app_common_pkg_get_sociedades_accionistas_fn(pstnombre1, 1);
end if;
end if;
if pstsociedades1 is not null then
if pstsociedades2 is not null then
return app_common_pkg_get_sociedades_accionistas_fn(pstsociedades1||, ||pstsociedades2,2);
else
return app_common_pkg_get_sociedades_accionistas_fn(pstsociedades1, 2);
end if;
end if;
if pstnombre2 is not null then
return app_common_pkg_get_sociedades_accionistas_fn(pstnombre1||, ||pstnombre2, 1);
end if;
if pstsociedades2 is not null then
return app_common_pkg_get_sociedades_accionistas_fn(pstsociedades1||, ||pstsociedades2, 2);
end if;
*/
return concat( app_common_pkg_get_sociedades_accionistas_fn(pstnombre1,1), ' ' , app_common_pkg_get_sociedades_accionistas_fn(pstsociedades1,2) , ' ' , app_common_pkg_get_sociedades_accionistas_fn(pstnombre2,1), ' ' , app_common_pkg_get_sociedades_accionistas_fn(pstsociedades2,2)) ;/* dmap converted statement end */end;
$body$
language plpgsql
;
