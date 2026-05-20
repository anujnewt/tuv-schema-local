create or replace procedure admp."admp_copia2_programa_pr"  ( idaccion varchar, idparrilla varchar, idparrilladet varchar, idusuario numeric, idcanalorigen numeric, fechainiorigen varchar, fechafinorigen varchar, idcanaldestino numeric, fechainidestino varchar, fechafindestino varchar, horainicio varchar, horainicioreal varchar, horainicioiso varchar, horafinal varchar, horafinalreal varchar, horafinaliso varchar, lunes varchar, martes varchar, miercoles varchar, jueves varchar, viernes varchar, sabado varchar, domingo varchar, idtipoparrilla numeric, mensaje inout varchar) as $body$
declare
flg0 text;
flg2 text;
flg3 text;
flg1 text;
-- pgv moved types end
horaini numeric := 0;
horafin numeric := 0;
horainimas numeric := 0;
horafinmenos numeric := 0;
rec record;
det record;
begin
if idaccion = 'P' then
horaini := (replace(horainicio, ':',''))::numeric;
horafin := (replace(horafinal, ':',''))::numeric;
horainimas := (replace(horainicio, ':',''))::numeric  + 1;
horafinmenos := (replace(horafinal, ':',''))::numeric  - 1;
declare
-- pgv moved types start
v_prg   admp_parrilla_det_tab%rowtype;
horainiprg numeric := 0;
horafinprg numeric := 0;
duracion numeric := 0;
intervalo numeric := 0;
fechaintervalo timestamp(0) := to_timestamp(fechainidestino,'dd/mm/yyyy');
idtipoparrilla numeric :=0;
idnuevoparrilla numeric :=-1;
idnuevodetparrilla numeric :=-1;
idnuevorating numeric :=-1;
idnumerodia varchar(5) :=-1;
flaginserta numeric :=-1;
cprograma cursor  for select * from admp_parrilla_det_tab where id_parrilla_det = idparrilladet;
begin
select id_tipo_parrilla into strict idtipoparrilla from admp_parrilla_tab where id_parrilla = idparrilla;
open cprograma;
loop
fetch cprograma into v_prg;
flg0 := found;
flg1 := found;
flg2 := found;
flg3 := found;
exit when (not flg0)or(not flg1)or(not flg2)or(not flg3);/* dmap converted statement start *//* apply on cprograma */
perform dbms_output.put_line(  concat(v_prg.id_parrilla, ' ' , v_prg.id_parrilla_det)  );/* dmap converted statement end */
horainiprg := (replace(v_prg.des_hora_inicio, ':',''))::numeric;
horafinprg := (replace(v_prg.des_hora_fin, ':',''))::numeric;
duracion := horafinprg - horainiprg;/* dmap converted statement start */
perform dbms_output.put_line( concat('fechaaaa ', fechaintervalo)) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line(  concat(duracion, ' : ' , duracion)) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat( to_timestamp(fechafindestino,'dd/mm/yyyy'), ' : ' , to_timestamp(fechainidestino,'dd/mm/yyyy'))) ;/* dmap converted statement end */
for rec in (
select  id_parrilla_det
from    admp_parrilla_copia_vw
where   id_canal = idcanaldestino
and     fec_parrilla between to_timestamp(fechainidestino,'dd/mm/yyyy') and to_timestamp(fechafindestino,'dd/mm/yyyy')
and (
(replace(des_hora_inicio, ':',''))::numeric  between  horaini and horafinmenos
or     (replace(des_hora_fin, ':',''))::numeric  between  horainimas and horafin
or (     (replace(des_hora_inicio, ':',''))::numeric  <  horaini
and (replace(des_hora_fin, ':',''))::numeric  >  horafin))
and     dia in (case when nullif(lunes::text, '') is null then lunes       else '1' end,
case when nullif(martes::text, '') is null then martes      else '2' end,
case when nullif(miercoles::text, '') is null then miercoles   else '3' end,
case when nullif(jueves::text, '') is null then jueves      else '4' end,
case when nullif(viernes::text, '') is null then viernes     else '5' end,
case when nullif(sabado::text, '') is null then sabado      else '6' end,
case when nullif(domingo::text, '') is null then domingo     else '7' end)
and     id_tipo_parrilla = idtipoparrilla
)
loop
delete from admp_target_parr_det_tab where id_parrilla_det = rec.id_parrilla_det;
delete from admp_parrilla_det_tab where id_parrilla_det = rec.id_parrilla_det;/* dmap converted statement start */
perform dbms_output.put_line( concat('Data Deleted: ', rec.id_parrilla_det)) ;/* dmap converted statement end */
end loop;
select dmap_interval_to_days(to_timestamp(fechafindestino,'dd/mm/yyyy') - to_timestamp(fechainidestino,'dd/mm/yyyy')) into strict intervalo;/* dmap converted statement start */
perform dbms_output.put_line( concat('Intervalo: ', intervalo)) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('Fecha Intervalo: ', fechaintervalo)) ;/* dmap converted statement end *//* dmap converted statement start */
loop
perform dbms_output.put_line( concat('Intervalo Actual = ', intervalo)) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('Fecha Intervalo Actual: ', fechaintervalo)) ;/* dmap converted statement end */
declare
v_cab   admp_parrilla_tab%rowtype;
ccabecero cursor  for select * from admp_parrilla_tab where fec_parrilla = fechaintervalo and id_canal = idcanaldestino and id_tipo_parrilla = idtipoparrilla;
begin
open ccabecero;
loop
fetch ccabecero into v_cab;
flg0 := found;
flg1 := found;
flg2 := found;
flg3 := found;
select 1 + trunc(fechaintervalo) - trunc(fechaintervalo, 'IW')  into strict idnumerodia;/* dmap converted statement start */
-- to_char(fechaintervalo,'D','nls_date_language=''mexican spanish''')
perform dbms_output.put_line( concat('eNTRO ULTIMO CICLO: ', idnumerodia)) ;/* dmap converted statement end */
flaginserta := -1;
if idnumerodia = '1' then
if nullif(lunes::text, '') is not null then
flaginserta := 1;/* dmap converted statement start */
perform dbms_output.put_line(  concat('LUNES ', flaginserta)) ;/* dmap converted statement end */
end if;
end if;
if idnumerodia = '2' then
if nullif(martes::text, '') is not null then
flaginserta := 1;
perform dbms_output.put_line( 'MARTES' );
end if;
end if;
if idnumerodia = '3' then
if nullif(miercoles::text, '') is not null then
flaginserta := 1;
perform dbms_output.put_line( 'MIERCOLES' );
end if;
end if;
if idnumerodia = '4' then
if nullif(jueves::text, '') is not null then
flaginserta := 1;
perform dbms_output.put_line( 'JUEVES' );
end if;
end if;
if idnumerodia = '5' then
if nullif(viernes::text, '') is not null then
flaginserta := 1;
perform dbms_output.put_line( 'VIERNES' );
end if;
end if;
if idnumerodia = '6' then
if nullif(sabado::text, '') is not null then
flaginserta := 1;
perform dbms_output.put_line( 'SABADO' );
end if;
end if;
if idnumerodia = '7' then
perform dbms_output.put_line( 'ENTRA EN DOMINGO' );
if nullif(domingo::text, '') is not null then
flaginserta := 1;
perform dbms_output.put_line( 'DOMINGO' );
end if;
end if;/* dmap converted statement start */
perform dbms_output.put_line( concat('FLAG: ', flaginserta)) ;/* dmap converted statement end *//* dmap converted statement start */
if flaginserta = '1' then
if not found then
perform dbms_output.put_line( concat('no existe', v_cab.id_parrilla)) ;/* dmap converted statement end */
insert into admp_parrilla_tab( id_parrilla,  fec_parrilla,         id_canal,num_version,id_estado,num_created_by,fec_creation_date, num_last_update, fec_last_update,num_last_update_login,atributo1,atributo2,atributo3,atributo4,atributo5,atributo6,atributo7,atributo8,atributo9,atributo10,atributo11,atributo12,atributo13,atributo14,atributo15,attribute_category, id_tipo_parrilla )
values (                                -1 ,fechaintervalo,   idcanaldestino,          1,        1,     idusuario,          clock_timestamp(),       idusuario,         clock_timestamp(),            idusuario,     null,     null,     null,     null,     null,     null,     null,     null,     null,      null,      null,      null,      null,      null,      null,              null,   idtipoparrilla )
returning id_parrilla into idnuevoparrilla;/* dmap converted statement start */
perform dbms_output.put_line(  concat('inserto = ', idnuevoparrilla)  );/* dmap converted statement end */
else
idnuevoparrilla := v_cab.id_parrilla;/* dmap converted statement start */
perform dbms_output.put_line( concat('existe = ', v_cab.id_parrilla)) ;/* dmap converted statement end */
end if;
insert into  admp_parrilla_det_tab(
id_parrilla_det,
id_parrilla,
id_genero,
des_ciclo ,
des_hora_inicio,
des_hora_fin,
des_hora_inicio_real,
des_hora_fin_real,
des_hora_inicio_iso,
des_hora_fin_iso,
id_tipo,
des_programa,
des_programa_original,
id_clasificacion,
id_formato,
id_restriccion,
des_notas,
num_transmisiones,
fec_ultima_transmision,
des_ultima_transmision,
num_color,
num_sap,
num_temporada,
num_repeticion_temp,
cod_programa_ibope,
des_programa_ibope,
id_fuente,
id_evento,
des_descripcion,
num_fuente_xls,
num_cambio_prog,
fec_cambio_prog,
des_capitulo,
num_created_by,
fec_creation_date,
num_last_update,
fec_last_update,
num_last_update_login,
atributo1,
atributo2,
atributo3,
atributo4,
atributo5,
atributo6,
atributo7,
atributo8,
atributo9,
atributo10,
atributo11,
atributo12,
atributo13,
atributo14,
atributo15,
attribute_category
)
values ( -1 ,
idnuevoparrilla,
v_prg.id_genero,
v_prg.des_ciclo ,
horainicio,
horafinal,
horainicioreal,
horafinalreal,
horainicioiso,
horafinaliso,
v_prg.id_tipo,
v_prg.des_programa,
v_prg.des_programa_original,
v_prg.id_clasificacion,
v_prg.id_formato,
v_prg.id_restriccion,
v_prg.des_notas,
v_prg.num_transmisiones,
v_prg.fec_ultima_transmision,
v_prg.des_ultima_transmision,
v_prg.num_color,
v_prg.num_sap,
v_prg.num_temporada,
v_prg.num_repeticion_temp,
v_prg.cod_programa_ibope,
v_prg.des_programa_ibope,
v_prg.id_fuente,
v_prg.id_evento,
v_prg.des_descripcion,
v_prg.num_fuente_xls,
v_prg.num_cambio_prog,
v_prg.fec_cambio_prog,
v_prg.des_capitulo,
idusuario,
clock_timestamp(),
idusuario,
clock_timestamp(),
idusuario,
v_prg.atributo1,
v_prg.atributo2,
v_prg.atributo3,
v_prg.atributo4,
v_prg.atributo5,
v_prg.atributo6,
v_prg.atributo7,
v_prg.atributo8,
v_prg.atributo9,
v_prg.atributo10,
v_prg.atributo11,
v_prg.atributo12,
v_prg.atributo13,
v_prg.atributo14,
v_prg.atributo15,
v_prg.attribute_category
)
returning id_parrilla_det into idnuevodetparrilla;/* dmap converted statement start */
perform dbms_output.put_line(  concat('inserto detalle = ', idnuevodetparrilla)  );/* dmap converted statement end */
/*se genera el rating*/
declare
v_rat   admp_target_parr_det_tab%rowtype;
crating cursor  for select * from admp_target_parr_det_tab where id_parrilla_det = idparrilladet;
begin
open crating;
loop
fetch crating into v_rat;
flg0 := found;
flg1 := found;
flg2 := found;
flg3 := found;
exit when (not flg0)or(not flg1)or(not flg2)or(not flg3);/* dmap converted statement start *//* apply on crating */
perform dbms_output.put_line(  concat(v_rat.id_target_parr_det, ' ' , v_rat.id_parrilla_det , ' ' , v_rat.id_target)  );/* dmap converted statement end */
insert into  admp_target_parr_det_tab(
id_target_parr_det,
id_parrilla_det,
id_target,
can_rating ,
num_created_by,
fec_creation_date,
num_last_update,
fec_last_update,
num_last_update_login,
atributo1,
atributo2,
atributo3,
atributo4,
atributo5,
atributo6,
atributo7,
atributo8,
atributo9,
atributo10,
atributo11,
atributo12,
atributo13,
atributo14,
atributo15,
attribute_category
)
values ( -1 ,
idnuevodetparrilla,
v_rat.id_target,
v_rat.can_rating ,
idusuario,
clock_timestamp(),
idusuario,
clock_timestamp(),
idusuario,
v_rat.atributo1,
v_rat.atributo2,
v_rat.atributo3,
v_rat.atributo4,
v_rat.atributo5,
v_rat.atributo6,
v_rat.atributo7,
v_rat.atributo8,
v_rat.atributo9,
v_rat.atributo10,
v_rat.atributo11,
v_rat.atributo12,
v_rat.atributo13,
v_rat.atributo14,
v_rat.atributo15,
v_rat.attribute_category
)
returning id_target_parr_det into idnuevorating;/* dmap converted statement start */
perform dbms_output.put_line(  concat('inserto rating = ', idnuevorating)  );/* dmap converted statement end */
end loop;
close crating;
end;
end if;
fechaintervalo := fechaintervalo + 1;
intervalo := intervalo - 1;
exit;
end loop;
close ccabecero;
if intervalo < 0 then
exit;
end if;
end;
end loop;
end loop;
close cprograma;
end;
elsif idaccion = 'D' then
declare
intervalo number := 0;
fechaintervalo date := to_timestamp(fechainidestino,'dd/mm/yyyy');
fechainicio date := to_timestamp(fechainiorigen,'dd/mm/yyyy');
idnuevoparrilla number :=-1;
idnuevodetparrilla number :=-1;
idnuevorating number :=-1;
idparrillaorigen number :=0;
begin
perform dbms_output.put_line( 'entro D'  );
for rec in (
select  id_parrilla_det
from    admp_parrilla_copia_vw
where   id_canal = idcanaldestino
and     fec_parrilla between to_timestamp(fechainidestino,'dd/mm/yyyy') and to_timestamp(fechafindestino,'dd/mm/yyyy')
and     id_tipo_parrilla = idtipoparrilla
)
loop
delete from admp_target_parr_det_tab where id_parrilla_det = rec.id_parrilla_det;
delete from admp_parrilla_det_tab where id_parrilla_det = rec.id_parrilla_det;/* dmap converted statement start */
perform dbms_output.put_line( concat('Data Deleted: ', rec.id_parrilla_det)) ;/* dmap converted statement end */
end loop;
select dmap_interval_to_days(to_timestamp(fechafinorigen,'dd/mm/yyyy') - to_timestamp(fechainiorigen,'dd/mm/yyyy')) into strict intervalo;/* dmap converted statement start */
--dbms_output.put_line ('Intervalo: ' || intervalo);
--dbms_output.put_line ('Fecha Intervalo: ' || fechaintervalo);
loop
perform dbms_output.put_line( concat('Intervalo Actual = ', intervalo)) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('Fecha Intervalo Actual: ', fechaintervalo)) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('Fecha Inicio Actual: ', fechainicio)  );/* dmap converted statement end */
begin
select id_parrilla into strict idparrillaorigen from admp_parrilla_tab where fec_parrilla = fechainicio and id_canal = idcanalorigen and id_tipo_parrilla = idtipoparrilla;
exception
when no_data_found then
idparrillaorigen := null;/* dmap converted statement start */
perform dbms_output.put_line( concat('ID Parrilla a copiar ES NULL ', idparrillaorigen)) ;/* dmap converted statement end */
end;/* dmap converted statement start */
perform dbms_output.put_line( concat('ID Parrilla a copiar: ', idparrillaorigen)  );/* dmap converted statement end */
declare
v_cab   admp_parrilla_tab%rowtype;
ccabecero cursor  for select * from admp_parrilla_tab where fec_parrilla = fechaintervalo and id_canal = idcanaldestino and id_tipo_parrilla = idtipoparrilla;
begin
open ccabecero;
loop
fetch ccabecero into v_cab;
flg0 := found;
flg1 := found;
flg2 := found;
flg3 := found;/* dmap converted statement start */
if not found then
perform dbms_output.put_line( concat('no existe', v_cab.id_parrilla)) ;/* dmap converted statement end */
if nullif(idparrillaorigen::text, '') is not null then
insert into admp_parrilla_tab( id_parrilla,   fec_parrilla,          id_canal, num_version,id_estado,num_created_by,fec_creation_date, num_last_update, fec_last_update,num_last_update_login,atributo1,atributo2,atributo3,atributo4,atributo5,atributo6,atributo7,atributo8,atributo9,atributo10,atributo11,atributo12,atributo13,atributo14,atributo15,attribute_category, id_tipo_parrilla )
values (                                -1 , fechaintervalo,    idcanaldestino,           1,        1,     idusuario,          clock_timestamp(),       idusuario,         clock_timestamp(),            idusuario,     null,     null,     null,     null,     null,     null,     null,     null,     null,      null,      null,      null,      null,      null,      null,              null,   idtipoparrilla )
returning id_parrilla into idnuevoparrilla;/* dmap converted statement start */
perform dbms_output.put_line(  concat('inserto = ', idnuevoparrilla)  );/* dmap converted statement end */
end if;
else
idnuevoparrilla := v_cab.id_parrilla;/* dmap converted statement start */
perform dbms_output.put_line( concat('existe = ', v_cab.id_parrilla)) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
if nullif(idparrillaorigen::text, '') is not null then
for det in (
select  id_parrilla_det,
id_parrilla,
id_genero,
des_ciclo ,
des_hora_inicio,
des_hora_fin,
des_hora_inicio_real,
des_hora_fin_real,
des_hora_inicio_iso,
des_hora_fin_iso,
id_tipo,
des_programa,
des_programa_original,
id_clasificacion,
id_formato,
id_restriccion,
des_notas,
num_transmisiones,
fec_ultima_transmision,
des_ultima_transmision,
num_color,
num_sap,
num_temporada,
num_repeticion_temp,
cod_programa_ibope,
des_programa_ibope,
id_fuente,
id_evento,
des_descripcion,
num_fuente_xls,
num_cambio_prog,
fec_cambio_prog,
des_capitulo,
num_created_by,
fec_creation_date,
num_last_update,
fec_last_update,
num_last_update_login,
atributo1,
atributo2,
atributo3,
atributo4,
atributo5,
atributo6,
atributo7,
atributo8,
atributo9,
atributo10,
atributo11,
atributo12,
atributo13,
atributo14,
atributo15,
attribute_category
from    admp_parrilla_det_tab
where   id_parrilla = idparrillaorigen
)
loop
perform dbms_output.put_line( concat('entro ultimo loop = ', det.id_parrilla)) ;/* dmap converted statement end */
insert into  admp_parrilla_det_tab(
id_parrilla_det,
id_parrilla,
id_genero,
des_ciclo ,
des_hora_inicio,
des_hora_fin,
des_hora_inicio_real,
des_hora_fin_real,
des_hora_inicio_iso,
des_hora_fin_iso,
id_tipo,
des_programa,
des_programa_original,
id_clasificacion,
id_formato,
id_restriccion,
des_notas,
num_transmisiones,
fec_ultima_transmision,
des_ultima_transmision,
num_color,
num_sap,
num_temporada,
num_repeticion_temp,
cod_programa_ibope,
des_programa_ibope,
id_fuente,
id_evento,
des_descripcion,
num_fuente_xls,
num_cambio_prog,
fec_cambio_prog,
des_capitulo,
num_created_by,
fec_creation_date,
num_last_update,
fec_last_update,
num_last_update_login,
atributo1,
atributo2,
atributo3,
atributo4,
atributo5,
atributo6,
atributo7,
atributo8,
atributo9,
atributo10,
atributo11,
atributo12,
atributo13,
atributo14,
atributo15,
attribute_category
)
values (
-1 ,
idnuevoparrilla,
det.id_genero,
det.des_ciclo ,
det.des_hora_inicio,
det.des_hora_fin,
det.des_hora_inicio_real,
det.des_hora_fin_real,
det.des_hora_inicio_iso,
det.des_hora_fin_iso,
det.id_tipo,
det.des_programa,
det.des_programa_original,
det.id_clasificacion,
det.id_formato,
det.id_restriccion,
det.des_notas,
det.num_transmisiones,
det.fec_ultima_transmision,
det.des_ultima_transmision,
det.num_color,
det.num_sap,
det.num_temporada,
det.num_repeticion_temp,
det.cod_programa_ibope,
det.des_programa_ibope,
det.id_fuente,
det.id_evento,
det.des_descripcion,
det.num_fuente_xls,
det.num_cambio_prog,
det.fec_cambio_prog,
det.des_capitulo,
idusuario,
clock_timestamp(),
idusuario,
clock_timestamp(),
idusuario,
det.atributo1,
det.atributo2,
det.atributo3,
det.atributo4,
det.atributo5,
det.atributo6,
det.atributo7,
det.atributo8,
det.atributo9,
det.atributo10,
det.atributo11,
det.atributo12,
det.atributo13,
det.atributo14,
det.atributo15,
det.attribute_category
)
returning id_parrilla_det into idnuevodetparrilla;/* dmap converted statement start */
perform dbms_output.put_line( concat('detalle insertado = ', idnuevodetparrilla)) ;/* dmap converted statement end */
insert into  admp_target_parr_det_tab(
id_target_parr_det,
id_parrilla_det,
id_target,
can_rating ,
num_created_by,
fec_creation_date,
num_last_update,
fec_last_update,
num_last_update_login,
atributo1,
atributo2,
atributo3,
atributo4,
atributo5,
atributo6,
atributo7,
atributo8,
atributo9,
atributo10,
atributo11,
atributo12,
atributo13,
atributo14,
atributo15,
attribute_category
)
select -1 ,
idnuevodetparrilla,
id_target,
can_rating ,
idusuario,
clock_timestamp(),
idusuario,
clock_timestamp(),
idusuario,
atributo1,
atributo2,
atributo3,
atributo4,
atributo5,
atributo6,
atributo7,
atributo8,
atributo9,
atributo10,
atributo11,
atributo12,
atributo13,
atributo14,
atributo15,
attribute_category
from admp_target_parr_det_tab
where id_parrilla_det = det.id_parrilla_det;
perform dbms_output.put_line('inserto target = ');
end loop;
end if;
fechaintervalo := fechaintervalo + 1;
fechainicio := fechainicio + 1;
intervalo := intervalo - 1;
exit;
end loop;
close ccabecero;
if intervalo < 0 then
exit;
end if;
end;
end loop;
end;
end if;
/* commit; */
mensaje := 'ok';
exception
when others then
rollback;/* dmap converted statement start */
raise exception '%',  concat('An error was encountered - ', sqlstate, ' -ERROR- ', sqlerrm)  using errcode = '45001';/* dmap converted statement end */
end;
$body$
language plpgsql
;
