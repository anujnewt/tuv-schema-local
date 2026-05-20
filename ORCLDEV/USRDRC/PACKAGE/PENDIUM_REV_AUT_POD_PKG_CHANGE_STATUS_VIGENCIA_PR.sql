create or replace procedure usrdrc.pendium_rev_aut_pod_pkg_change_status_vigencia_pr () as $body$
declare
-- pgv moved types start
-- pgv moved types end
lfec_fin timestamp(0);
max_indice integer;
indice integer;
indiceaux integer;
desc_apod_poder text;
desc_apod_poder_temp text;
desc_apod_esc text;
id_escritura_ant numeric := 0;
des_podertipo_ant varchar(2000);
/******* lista de apoderados a revocar *********/
poderes_cur cursor for
select
poder.id_opoder_ep_pk
,poder.id_ep_fk
,poder.desc_apoderados
,esc.desc_apoderados as desc_apoderados_esc
,poder.des_podertipo
,poder.des_poder
,esc.ind_tipo_escritura
from  pendium_otorgapoder_ep_tab poder inner join pendium_escritura_poder_tab esc on esc.id_ep_pk = poder.id_ep_fk
where poder.id_ep_fk in ( select
poder.id_ep_fk
from  pendium_otorgapoder_ep_tab poder inner join pendium_escritura_poder_tab esc on esc.id_ep_pk = poder.id_ep_fk
where poder.id_opoder_ep_pk( select apod.id_opoder_ep_fk
from pendium_apoderado_ep_tab apod
inner join pendium_otorgapoder_ep_tab poder on apod.id_opoder_ep_fk = poder.id_opoder_ep_pk
inner join pendium_escritura_poder_tab esc on esc.id_ep_pk = poder.id_ep_fk
where poder.num_vigenciatipo(1,2,3)
and poder.ind_status = 1
and to_timestamp(poder.fec_vigenciafin,'DD/MM/YYYY, HH24:MI:SS') < clock_timestamp()
and apod.ind_status in (2))
)
order by poder.id_opoder_ep_pk
;
apoderados_cur cursor for
select
apod.id_apod_ep_pk
,apod.id_opoder_ep_fk
,apod.id_ep_fk
,apod.desc_nom_empl
,poder.fec_vigenciafin
from pendium_apoderado_ep_tab apod
inner join pendium_otorgapoder_ep_tab poder on apod.id_opoder_ep_fk = poder.id_opoder_ep_pk
inner join pendium_escritura_poder_tab esc on esc.id_ep_pk = poder.id_ep_fk
where poder.num_vigenciatipo in (1,2,3)
and poder.ind_status = 1
and to_timestamp(poder.fec_vigenciafin,'DD/MM/YYYY, HH24:MI:SS') < clock_timestamp()
and apod.ind_status in (1,3)
and ind_tipoapoderado=1;
begin
/* dmap converted statement start */
-- package does not have global variables
--dmap conversion comment: gtt declaration added
/******* aplicar revocaciones *********/
for i in apoderados_cur
loop
update pendium_apoderado_ep_tab
set ind_status = 2
,desc_revoca =  concat('<label style="color:red;">V</label> Mandato Termino por Vigencia ', i.fec_vigenciafin
) ,ind_aprevoca = '1'
where id_apod_ep_pk = i.id_apod_ep_pk;/* dmap converted statement end *//* dmap converted statement start */
/* commit; */
--dbms_output.put_line(actulizar apoderado);
insert into pendium_revoca_ep_tab(id_opoder_ep_fk
,id_ep_fk
,id_apod_ep_fk
,ind_razonrevoca
,des_razonrevoca
,fec_revoca
,des_textorevoca
,desc_apendicerevoca
,ind_status)
values (
i.id_opoder_ep_fk
,i.id_ep_fk
,i.id_apod_ep_pk
, 3
,'Vigencia'
,i.fec_vigenciafin
, concat('Mandato Termino por Vigencia ', i.fec_vigenciafin
) ,1
,1
);/* dmap converted statement end */
-- dbms_output.put_line(inserta revocacion);
--select max(ind_aprevoca) into max_indice from pendium_apoderado_ep_tab where id_opoder_ep_fk = i.id_opoder_ep_fk and ind_status = 2;
select desc_apoderados into strict desc_apod_poder
from pendium_otorgapoder_ep_tab
where id_opoder_ep_pk = i.id_opoder_ep_fk;/* dmap converted statement start */
--desc_apod_poder := replace(desc_apod_poder,i.desc_nom_empl,i.desc_nom_empl ||  <label style=color:red;>v</label>);
desc_apod_poder := replace(desc_apod_poder,trim(both i.desc_nom_empl), concat(trim(both i.desc_nom_empl), '<sup NULLIF(style::text, '') IS NULLfont-size:8pt;''><label style="color:red;">V</label></sup>')) ;/* dmap converted statement end */
update pendium_otorgapoder_ep_tab set desc_apoderados = desc_apod_poder where id_opoder_ep_pk = i.id_opoder_ep_fk;
/* commit; */
perform dbms_output.put_line(i.desc_nom_empl);
end loop;
/******* actualizar descripcion de apoderados en escritura y poder  *********/
for e in poderes_cur
loop
select desc_apoderados into strict desc_apod_poder
from pendium_otorgapoder_ep_tab
where id_opoder_ep_pk = e.id_opoder_ep_pk;
select desc_apoderados into strict desc_apod_esc
from pendium_escritura_poder_tab
where id_ep_pk = e.id_ep_fk;/* dmap converted statement start */
if id_escritura_ant <> e.id_ep_fk then
if e.ind_tipo_escritura = 'PG' then
desc_apod_esc :=  concat('<div style="font-weight: bold;">', e.des_poder , '</div>') ;/* dmap converted statement end *//* dmap converted statement start */
else
desc_apod_esc :=  concat('<div style="font-weight: bold;">', e.des_podertipo , '</div><br>') ;/* dmap converted statement end */
end if;/* dmap converted statement start */
else
desc_apod_esc :=  concat(desc_apod_esc, '<br>') ;/* dmap converted statement end */
end if;
desc_apod_poder_temp := desc_apod_poder;
desc_apod_poder_temp := replace(desc_apod_poder_temp, 'null', '');/* dmap converted statement start */
if e.ind_tipo_escritura = 'PG' then
if id_escritura_ant = e.id_ep_fk  and des_podertipo_ant <> e.des_poder then
desc_apod_esc :=  concat(desc_apod_esc, '<div style="font-weight: bold;">' , e.des_poder , '</div>' , desc_apod_poder_temp) ;/* dmap converted statement end *//* dmap converted statement start */
else
desc_apod_esc :=  concat(desc_apod_esc, desc_apod_poder_temp) ;/* dmap converted statement end */
end if;
des_podertipo_ant := e.des_poder;/* dmap converted statement start */
else
if id_escritura_ant = e.id_ep_fk  and des_podertipo_ant <> e.des_podertipo then
desc_apod_esc :=  concat(desc_apod_esc, '<div style="font-weight: bold;">' , e.des_podertipo , '</div><br>' , desc_apod_poder_temp) ;/* dmap converted statement end *//* dmap converted statement start */
else
desc_apod_esc :=  concat(desc_apod_esc, desc_apod_poder_temp) ;/* dmap converted statement end */
end if;
des_podertipo_ant := e.des_podertipo;
end if;
id_escritura_ant := e.id_ep_fk;
update pendium_escritura_poder_tab set desc_apoderados = desc_apod_esc  where id_ep_pk = e.id_ep_fk;
/* commit; */
end loop;end;
$body$
language plpgsql
;
