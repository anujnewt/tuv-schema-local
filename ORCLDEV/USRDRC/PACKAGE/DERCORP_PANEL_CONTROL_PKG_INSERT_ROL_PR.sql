create or replace procedure usrdrc.dercorp_panel_control_pkg_insert_rol_pr ( pstnomrol varchar ,pstdescrol varchar ,pstnumexp numeric ,pstreportpre varchar ,pstreportper varchar ,pstseqidmenu numeric ,pstouterror inout varchar ,pinmodifico numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
linrolseq     numeric;
--linmenuseq    number;
lincountmenu  numeric;
linmaxidelem  numeric;
lstnomrol     varchar(1000);
lstrevokeemp  varchar(5000);
i record;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
lstnomrol := oracle.substr(pstnomrol,1,position('|' in pstnomrol)-1);
lstrevokeemp := oracle.substr(pstnomrol,instr(pstnomrol,'|',-1,1)+1);
if nullif(lstnomrol::text, '') is null then
lstnomrol:= pstnomrol;
lstrevokeemp := null;
end if;
if lstrevokeemp = 'null' then
lstrevokeemp := null;
end if;
select count(distinct id_menu) into strict  lincountmenu
from ss_menu_element_tab;
select max(id_menu_element) into strict linmaxidelem
from ss_menu_element_tab;
select nextval('dercorp_rol_sq') into strict linrolseq
;/* dmap converted statement start */
--select dercorp_menu_sq.nextval into linmenuseq
--from dual;
insert into ss_menu_tab( id_menu
,nom_name
,num_created_by
,fec_creation_date)
values ( pstseqidmenu--linmenuseq
, concat('MENU_', lstnomrol
) ,1
,clock_timestamp()
);/* dmap converted statement end */
insert into ss_rol_tab( id_rol
,nom_name
,des_description
,num_password_expiration_days
,id_menu
,num_created_by
,fec_creation_date
,atributo1
,atributo2
,atributo3)
values ( linrolseq
,lstnomrol
,pstdescrol
,pstnumexp
,pstseqidmenu--linmenuseq
,pinmodifico
,clock_timestamp()
,lstrevokeemp
,case when pstreportpre='null' then null  else pstreportpre end
,case when pstreportper='null' then null  else pstreportper end );
insert into ss_rol_change_log_tab(
id_rol_change_log,
num_created_by,
fec_change_date,
des_status,
id_rol,
nom_rol
)
values (
nextval('ss_rol_access_log_sq'),
pinmodifico,
clock_timestamp(),
'CREATED ROL',
linrolseq,
lstnomrol
);
for i in ( select   *
from     ss_menu_element_tab
where    id_menu= 1
order by  id_menu_element
)
loop
insert into ss_menu_element_tab( id_menu_element
,id_menu
,id_section
,id_menu_element_parent
,nom_name
,id_order
,des_target
,num_created_by
,fec_creation_date)
values ( linmaxidelem + i.id_menu_element  --(lincountmenu*12)+ i.id_menu_element
,pstseqidmenu--linmenuseq
,i.id_section
--,decode(i.id_menu_element_parent,0,0,(lincountmenu*12)+ i.id_menu_element_parent)
,case when i.id_menu_element_parent=0 then 0  else linmaxidelem+ i.id_menu_element_parent end
,i.nom_name
,i.id_order
,i.des_target
,1
,clock_timestamp()
);
end loop;
exception
when others then
pstouterror := sqlerrm;end;
$body$
language plpgsql
;
