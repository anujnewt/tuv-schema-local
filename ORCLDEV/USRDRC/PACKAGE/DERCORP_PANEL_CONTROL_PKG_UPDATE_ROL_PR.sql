create or replace procedure usrdrc.dercorp_panel_control_pkg_update_rol_pr ( pinidrol numeric ,pstnomrol varchar ,pstdescrol varchar ,pstnumexp numeric ,pstreportpre varchar ,pstreportper varchar ,pstouterror inout varchar ,pinmodifico numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
linidmenu numeric;
lstnomrol     varchar(1000);
lstrevokeemp  varchar(5000);
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
lstnomrol := oracle.substr(pstnomrol,1,position('|' in pstnomrol)-1);
lstrevokeemp := oracle.substr(pstnomrol,instr(pstnomrol,'|',-1,1)+1);
if nullif(lstnomrol::text, '') is null then
lstnomrol:= pstnomrol;
lstrevokeemp := null;
end if;
update  ss_rol_tab  set nom_name                      = lstnomrol
,des_description               = pstdescrol
,num_password_expiration_days  = pstnumexp
,num_last_updated_by           = pinmodifico
,fec_last_update_date          = clock_timestamp()
,atributo1                     = case when lstrevokeemp='null' then null  else lstrevokeemp end
,atributo2                     = case when pstreportpre='null' then null  else pstreportpre end
,atributo3                     = case when pstreportper='null' then null  else pstreportper end
where                   id_rol                        = pinidrol;
update  ss_menu_element_tab set atributo1 = 0
where   id_menu = linidmenu;
delete  from dercorp_rol_seccion_tab
where   id_rol = pinidrol;
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
'UPDATE ROL',
pinidrol,
lstnomrol
);
exception when others
then
pstouterror := sqlerrm;end;
$body$
language plpgsql
;
