create or replace procedure usrdrc.dercorp_panel_control_pkg_elimina_rol_pr ( pinidrol numeric ,pstouterror inout varchar ,pinmodifico numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
linidmenu   numeric;
lincountrol numeric;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
begin
select id_menu into strict linidmenu
from   ss_rol_tab
where  id_rol   = pinidrol;
exception
when others then
linidmenu := 0;
end;
begin
select count(*) into strict lincountrol
from   ss_user_rol_tab
where  id_rol   = pinidrol;
exception
when others then
lincountrol := 0;
end;
if lincountrol = 0 then
delete from ss_menu_element_tab
where  id_menu  = linidmenu;
delete from ss_menu_tab
where  id_menu  = linidmenu;
delete from ss_user_rol_tab
where  id_rol   = pinidrol;
delete from dercorp_rol_seccion_tab
where  id_rol   = pinidrol;
insert into ss_rol_change_log_tab(
id_rol_change_log,
num_last_updated_by,
fec_change_date,
des_status,
id_rol,
nom_rol
)
values (
nextval('ss_rol_access_log_sq'),
pinmodifico,
clock_timestamp(),
'DELETED ROL',
pinidrol,
(select nom_name
from   ss_rol_tab
where  id_rol   = pinidrol)
);
delete from ss_rol_tab  where  id_rol   = pinidrol;
else
pstouterror:= 'El Rol no puede ser borrado ya que esta siendo ocupado';
end if;end;
$body$
language plpgsql
;
