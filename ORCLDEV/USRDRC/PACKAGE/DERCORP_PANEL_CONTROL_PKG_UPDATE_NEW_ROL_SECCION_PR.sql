create or replace procedure usrdrc.dercorp_panel_control_pkg_update_new_rol_seccion_pr (pstrolseccion varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
lstdelimited  varchar(100);
lstidrol      varchar(100);
lstidseccion  varchar(100);
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
begin
lstdelimited := replace(pstrolseccion,'chkp_','');
lstidseccion := oracle.substr(lstdelimited, 1 ,instr(lstdelimited, '_', 1, 1)-1);
--lstidrol     := oracle.substr(lstdelimited, instr(lstdelimited,_, -1, 1)+1);
select max(id_rol) into strict  lstidrol
from   ss_rol_tab;
exception
when others then
lstidseccion:= 0;
lstidrol    := 0;
end;
insert into dercorp_rol_seccion_tab(id_rol,
id_seccion,
num_created_by,
fec_creation_date)
values ( lstidrol,
lstidseccion,
1,
clock_timestamp()
);end;
$body$
language plpgsql
;
