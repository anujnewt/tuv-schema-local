create or replace procedure admp."admp_copia_oficial_pr"  ( pistidaccion varchar, pistdetalles varchar, piinidusuario numeric, piinidcanalorigen numeric, pistfechainiorigen varchar, pistfechafinorigen varchar, piinidcanaldestino numeric, pistfechainidestino varchar, pistfechafindestino varchar, pistlunes varchar, pistmartes varchar, pistmiercoles varchar, pistjueves varchar, pistviernes varchar, pistsabado varchar, pistdomingo varchar, piinidtipoparrilla numeric, piinidtipoparrilladestino numeric, postmensaje inout varchar ) as $body$
declare
flg0 text;
flg2 text;
flg3 text;
flg1 text;
-- pgv moved types end
linhoraini numeric := 0;
linhorafin numeric := 0;
linhorainimas numeric := 0;
linhorafinmenos numeric := 0;
ltbprograma record;
ltbrec record;
ltbdetalle record;
begin
if pistidaccion = 'P' then
declare
-- pgv moved types start
linintervalo numeric := 0;
ldtfechaintervalo timestamp(0) := to_timestamp(pistfechainidestino,'dd/mm/yyyy');
linidnuevoparrilla numeric :=-1;
linidnuevoparrillasig numeric :=-1;
lstidnumerodia varchar(5) :=-1;
lstidnumeroaux varchar(5) :=-1;
lstidnumeroprogram varchar(5) :=-1;
linflaginserta numeric :=-1;
lsthorainiciotmp varchar(8) :=-1;
lsthorafintmp varchar(8) :=-1;
lsthorainicioiso varchar(8) :=-1;
lsthorafiniso varchar(8) :=-1;
lsthorafinaux varchar(8) :=-1;
lsthorafinisoaux varchar(8) :=-1;
linhorafinisonum numeric := -1;
lsthorainicioaux varchar(8) :=-1;
lsthorainicioisoaux varchar(8) :=-1;
linhorainiiso numeric := 0;
linlength numeric := 0;
linidnuevodetparrilla numeric :=-1;
begin
for ltbprograma in (
select * from admp.admp_parrilla_copia_vw where id_parrilla_det in (select array_to_string(a,'') from regexp_matches(pistdetalles,'[^,]+', 'g') as foo(a)))
loop
select 1 + trunc((select fec_parrilla
from admp.admp_parrilla_copia_vw
where id_parrilla_det = ltbprograma.id_parrilla_det)-1)
- trunc((select fec_parrilla
from admp.admp_parrilla_copia_vw
where id_parrilla_det = ltbprograma.id_parrilla_det)-1, 'IW')
into strict lstidnumeroprogram;
if (replace(ltbprograma.des_hora_fin, ':',''))::numeric  <= 10000 then
linhoraini := (replace(
concat('24', oracle.substr(ltbprograma.des_hora_inicio, 3)),':',''))::numeric;
linhorainimas := (replace(
concat('24', oracle.substr(ltbprograma.des_hora_inicio, 3)),':',''))::numeric  + 1;
if oracle.substr(ltbprograma.des_hora_fin, 1, 2) = '00' then
linhorafin := (replace(
concat('24', oracle.substr(ltbprograma.des_hora_fin, 3)),':',''))::numeric;
linhorafinmenos := (replace(
concat('24', oracle.substr(ltbprograma.des_hora_fin, 3)),':',''))::numeric  - 1;
elsif oracle.substr(ltbprograma.des_hora_fin, 1, 2) = '01' then
linhorafin := (replace(
concat('25', oracle.substr(ltbprograma.des_hora_fin, 3)),':',''))::numeric;
linhorafinmenos := (replace(
concat('25', oracle.substr(ltbprograma.des_hora_fin, 3)),':',''))::numeric  - 1;
end if;
for ltbrec in (
select  id_parrilla_det
from    admp.admp_parrilla_copia_vw
where   id_canal = piinidcanaldestino
and     fec_parrilla between(to_timestamp(pistfechainidestino,'dd/mm/yyyy') - 1)
and (to_timestamp(pistfechafindestino,'dd/mm/yyyy') - 1)
and ((replace(des_hora_inicio, ':',''))::numeric
between  linhoraini
and      linhorafinmenos
or       (replace(des_hora_fin, ':',''))::numeric
between  linhorainimas
and linhorafin
or ((replace(des_hora_inicio, ':',''))::numeric  <  linhoraini
and (replace(des_hora_fin, ':',''))::numeric  >  linhorafin))
and     dia = lstidnumeroprogram
and     id_tipo_parrilla = piinidtipoparrilladestino)
loop
delete from admp.admp_target_parr_det_tab
where id_parrilla_det = ltbrec.id_parrilla_det;
delete from admp.admp_parrilla_det_tab
where id_parrilla_det = ltbrec.id_parrilla_det;
end loop;
elsif (replace(ltbprograma.des_hora_inicio, ':',''))::numeric  < 10000
and (replace(ltbprograma.des_hora_fin, ':',''))::numeric  > 10000 then
linhoraini := (replace(
concat('24', oracle.substr(ltbprograma.des_hora_inicio, 3)),':',''))::numeric;
linhorainimas := (replace(
concat('24', oracle.substr(ltbprograma.des_hora_inicio, 3)),':',''))::numeric  + 1;
linhorafin := 250000;
linhorafinmenos := 249999;
for ltbrec in (
select  id_parrilla_det
from    admp.admp_parrilla_copia_vw
where   id_canal = piinidcanaldestino
and     fec_parrilla
between(to_timestamp(pistfechainidestino,'dd/mm/yyyy')-1)
and (to_timestamp(pistfechafindestino,'dd/mm/yyyy')-1)
and ((replace(des_hora_inicio, ':',''))::numeric
between  linhoraini and linhorafinmenos
or       (replace(des_hora_fin, ':',''))::numeric
between  linhorainimas and linhorafin
or ((replace(des_hora_inicio, ':',''))::numeric  <  linhoraini
and      (replace(des_hora_fin, ':',''))::numeric  >  linhorafin))
and      dia = lstidnumeroprogram
and      id_tipo_parrilla = piinidtipoparrilladestino)
loop
delete from admp.admp_target_parr_det_tab
where id_parrilla_det = ltbrec.id_parrilla_det;
delete from admp.admp_parrilla_det_tab
where id_parrilla_det = ltbrec.id_parrilla_det;
end loop;
elsif (replace(ltbprograma.des_hora_inicio, ':',''))::numeric  < 60000
and (replace(ltbprograma.des_hora_fin, ':',''))::numeric  > 60000  then
linhoraini := 60000;
linhorainimas := 60001;
linhorafin := (replace(ltbprograma.des_hora_fin,':',''))::numeric;
linhorafinmenos :=
(replace(ltbprograma.des_hora_fin,':',''))::numeric  + 1;
for ltbrec in (
select  id_parrilla_det
from    admp.admp_parrilla_copia_vw
where   id_canal = piinidcanaldestino
and     fec_parrilla
between to_timestamp(pistfechainidestino,'dd/mm/yyyy')
and     to_timestamp(pistfechafindestino,'dd/mm/yyyy')
and ((replace(des_hora_inicio, ':',''))::numeric
between linhoraini and linhorafinmenos
or      (replace(des_hora_fin, ':',''))::numeric
between  linhorainimas and linhorafin
or ((replace(des_hora_inicio, ':',''))::numeric  <  linhoraini
and     (replace(des_hora_fin, ':',''))::numeric  >  linhorafin))
and     dia = ltbprograma.dia
and     id_tipo_parrilla = piinidtipoparrilladestino
)
loop
delete from admp.admp_target_parr_det_tab
where id_parrilla_det = ltbrec.id_parrilla_det;
delete from admp.admp_parrilla_det_tab
where id_parrilla_det = ltbrec.id_parrilla_det;
end loop;
elsif (replace(ltbprograma.des_hora_inicio, ':',''))::numeric  >= 060000 then
linhoraini := (replace(ltbprograma.des_hora_inicio, ':',''))::numeric;
linhorainimas :=
(replace(ltbprograma.des_hora_inicio, ':',''))::numeric  + 1;
linhorafin := (replace(ltbprograma.des_hora_fin, ':',''))::numeric;
linhorafinmenos :=
(replace(ltbprograma.des_hora_fin, ':',''))::numeric  - 1;
for ltbrec in (
select  id_parrilla_det
from    admp.admp_parrilla_copia_vw
where   id_canal = piinidcanaldestino
and     fec_parrilla
between to_timestamp(pistfechainidestino,'dd/mm/yyyy')
and     to_timestamp(pistfechafindestino,'dd/mm/yyyy')
and ((replace(des_hora_inicio, ':',''))::numeric
between  linhoraini and linhorafinmenos
or      (replace(des_hora_fin, ':',''))::numeric
between  linhorainimas and linhorafin
or ((replace(des_hora_inicio, ':',''))::numeric  <  linhoraini
and (replace(des_hora_fin, ':',''))::numeric  >  linhorafin))
and     dia = ltbprograma.dia
and     id_tipo_parrilla = piinidtipoparrilladestino
)
loop
delete from admp.admp_target_parr_det_tab
where id_parrilla_det = ltbrec.id_parrilla_det;
delete from admp.admp_parrilla_det_tab
where id_parrilla_det = ltbrec.id_parrilla_det;
end loop;
end if;
end loop;
select dmap_interval_to_days(to_timestamp(pistfechafindestino,'dd/mm/yyyy') -
to_timestamp(pistfechainidestino,'dd/mm/yyyy')) into strict linintervalo;
loop
declare
ltbcab   admp.admp_parrilla_tab%rowtype;
ltbnext  admp.admp_parrilla_tab%rowtype;
lcurcabecero cursor
for  select *
from admp.admp_parrilla_tab
where fec_parrilla = ldtfechaintervalo
and id_canal = piinidcanaldestino
and id_tipo_parrilla = piinidtipoparrilladestino;
lcurcabecerosiguiente cursor
for  select *
from admp.admp_parrilla_tab
where fec_parrilla = (ldtfechaintervalo - 1)
and id_canal = piinidcanaldestino
and id_tipo_parrilla = piinidtipoparrilladestino;
begin
open lcurcabecero;
open lcurcabecerosiguiente;
loop
fetch lcurcabecero into ltbcab;
flg0 := found;
flg1 := found;
flg2 := found;
flg3 := found;
fetch lcurcabecerosiguiente into ltbnext;
select 1 + trunc(ldtfechaintervalo) -
trunc(ldtfechaintervalo, 'IW')
into strict lstidnumerodia;
linflaginserta := -1;
if lstidnumerodia = '1' then
if nullif(pistlunes::text, '') is not null then
linflaginserta := 1;
end if;
end if;
if lstidnumerodia = '2' then
if nullif(pistmartes::text, '') is not null then
linflaginserta := 1;
end if;
end if;
if lstidnumerodia = '3' then
if nullif(pistmiercoles::text, '') is not null then
linflaginserta := 1;
end if;
end if;
if lstidnumerodia = '4' then
if nullif(pistjueves::text, '') is not null then
linflaginserta := 1;
end if;
end if;
if lstidnumerodia = '5' then
if nullif(pistviernes::text, '') is not null then
linflaginserta := 1;
end if;
end if;
if lstidnumerodia = '6' then
if nullif(pistsabado::text, '') is not null then
linflaginserta := 1;
end if;
end if;
if lstidnumerodia = '7' then
if nullif(pistdomingo::text, '') is not null then
linflaginserta := 1;
end if;
end if;
if linflaginserta = '1' then
if not found then
insert into admp.admp_parrilla_tab(id_parrilla,
fec_parrilla,
id_canal,
num_version,
id_estado,
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
attribute_category,
id_tipo_parrilla)
values (-1 ,
ldtfechaintervalo,
piinidcanaldestino,
1,
1,
piinidusuario,
clock_timestamp(),
piinidusuario,
clock_timestamp(),
piinidusuario,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
piinidtipoparrilladestino )
returning id_parrilla into linidnuevoparrilla;
else
linidnuevoparrilla := ltbcab.id_parrilla;
end if;
if not found then
insert into admp.admp_parrilla_tab(id_parrilla,
fec_parrilla,
id_canal,
num_version,
id_estado,
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
attribute_category,
id_tipo_parrilla )
values (-1 ,
(ldtfechaintervalo - 1),
piinidcanaldestino,
1,
1,
piinidusuario,
clock_timestamp(),
piinidusuario,
clock_timestamp(),
piinidusuario,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
piinidtipoparrilladestino )
returning id_parrilla into linidnuevoparrillasig;
else
linidnuevoparrillasig := ltbnext.id_parrilla;
end if;
for ltbdetalle in (
select * from admp.admp_parrilla_det_tab where id_parrilla_det in (select array_to_string(a,'') from regexp_matches(pistdetalles,'[^,]+', 'g') as foo(a)))
loop
select 1 + trunc((select fec_parrilla from admp.admp_parrilla_copia_vw
where id_parrilla_det = ltbdetalle.id_parrilla_det))
- trunc((select fec_parrilla from admp.admp_parrilla_copia_vw
where id_parrilla_det = ltbdetalle.id_parrilla_det), 'IW')
into strict lstidnumeroaux;
if lstidnumeroaux = lstidnumerodia then
if (replace(ltbdetalle.des_hora_fin, ':',''))::numeric  <= 10000 then
if oracle.substr(ltbdetalle.des_hora_inicio, 1, 2) = '00' then
lsthorainiciotmp := concat('24',
oracle.substr(ltbdetalle.des_hora_inicio, 3));
lsthorainicioiso := concat('23',
oracle.substr(ltbdetalle.des_hora_inicio, 3));
elsif oracle.substr(ltbdetalle.des_hora_inicio, 1, 2) = '01' then
lsthorainiciotmp := concat('25',
oracle.substr(ltbdetalle.des_hora_inicio, 3));
lsthorainicioiso := concat('00',
oracle.substr(ltbdetalle.des_hora_inicio, 3));
end if;
if oracle.substr(ltbdetalle.des_hora_fin, 1, 2) = '00' then
lsthorafintmp := concat('24', oracle.substr(ltbdetalle.des_hora_fin, 3));
lsthorafiniso := concat('23', oracle.substr(ltbdetalle.des_hora_fin, 3));
elsif oracle.substr(ltbdetalle.des_hora_fin, 1, 2) = '01' then
lsthorafintmp := concat('25', oracle.substr(ltbdetalle.des_hora_fin, 3));
lsthorafiniso := concat('00', oracle.substr(ltbdetalle.des_hora_fin, 3));
end if;
insert into  admp.admp_parrilla_det_tab(id_parrilla_det,
id_parrilla,
id_genero,
des_ciclo,
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
attribute_category)
values (-1 ,
linidnuevoparrillasig,
ltbdetalle.id_genero,
ltbdetalle.des_ciclo ,
lsthorainiciotmp,
lsthorafintmp,
lsthorainiciotmp,
lsthorafintmp,
lsthorainicioiso,
lsthorafiniso,
ltbdetalle.id_tipo,
ltbdetalle.des_programa,
ltbdetalle.des_programa_original,
ltbdetalle.id_clasificacion,
ltbdetalle.id_formato,
ltbdetalle.id_restriccion,
ltbdetalle.des_notas,
ltbdetalle.num_transmisiones,
ltbdetalle.fec_ultima_transmision,
ltbdetalle.des_ultima_transmision,
ltbdetalle.num_color,
ltbdetalle.num_sap,
ltbdetalle.num_temporada,
ltbdetalle.num_repeticion_temp,
ltbdetalle.cod_programa_ibope,
ltbdetalle.des_programa_ibope,
ltbdetalle.id_fuente,
ltbdetalle.id_evento,
ltbdetalle.des_descripcion,
ltbdetalle.num_fuente_xls,
ltbdetalle.num_cambio_prog,
ltbdetalle.fec_cambio_prog,
ltbdetalle.des_capitulo,
piinidusuario,
clock_timestamp(),
piinidusuario,
clock_timestamp(),
piinidusuario,
ltbdetalle.atributo1,
ltbdetalle.atributo2,
ltbdetalle.atributo3,
ltbdetalle.atributo4,
ltbdetalle.atributo5,
ltbdetalle.atributo6,
ltbdetalle.atributo7,
ltbdetalle.atributo8,
ltbdetalle.atributo9,
ltbdetalle.atributo10,
ltbdetalle.atributo11,
ltbdetalle.atributo12,
ltbdetalle.atributo13,
ltbdetalle.atributo14,
ltbdetalle.atributo15,
ltbdetalle.attribute_category)
returning id_parrilla_det into linidnuevodetparrilla;
elsif (replace(ltbdetalle.des_hora_inicio, ':',''))::numeric  < 010000
and (replace(ltbdetalle.des_hora_fin, ':',''))::numeric  > 010000  then
if oracle.substr(ltbdetalle.des_hora_inicio, 1, 2) = '00' then
lsthorainiciotmp := concat('24',
oracle.substr(ltbdetalle.des_hora_inicio, 3));
lsthorainicioiso := concat('23',
oracle.substr(ltbdetalle.des_hora_inicio, 3));
elsif oracle.substr(ltbdetalle.des_hora_inicio, 1, 2) = '01' then
lsthorainiciotmp := concat('25',
oracle.substr(ltbdetalle.des_hora_inicio, 3));
lsthorainicioiso := concat('00',
oracle.substr(ltbdetalle.des_hora_inicio, 3));
end if;
insert into  admp.admp_parrilla_det_tab(id_parrilla_det,
id_parrilla,
id_genero,
des_ciclo,
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
attribute_category)
values (-1 ,
linidnuevoparrillasig,
ltbdetalle.id_genero,
ltbdetalle.des_ciclo ,
lsthorainiciotmp,
'25:00:00',
lsthorainiciotmp,
'25:00:00',
lsthorainicioiso,
'00:00:00',
ltbdetalle.id_tipo,
ltbdetalle.des_programa,
ltbdetalle.des_programa_original,
ltbdetalle.id_clasificacion,
ltbdetalle.id_formato,
ltbdetalle.id_restriccion,
ltbdetalle.des_notas,
ltbdetalle.num_transmisiones,
ltbdetalle.fec_ultima_transmision,
ltbdetalle.des_ultima_transmision,
ltbdetalle.num_color,
ltbdetalle.num_sap,
ltbdetalle.num_temporada,
ltbdetalle.num_repeticion_temp,
ltbdetalle.cod_programa_ibope,
ltbdetalle.des_programa_ibope,
ltbdetalle.id_fuente,
ltbdetalle.id_evento,
ltbdetalle.des_descripcion,
ltbdetalle.num_fuente_xls,
ltbdetalle.num_cambio_prog,
ltbdetalle.fec_cambio_prog,
ltbdetalle.des_capitulo,
piinidusuario,
clock_timestamp(),
piinidusuario,
clock_timestamp(),
piinidusuario,
ltbdetalle.atributo1,
ltbdetalle.atributo2,
ltbdetalle.atributo3,
ltbdetalle.atributo4,
ltbdetalle.atributo5,
ltbdetalle.atributo6,
ltbdetalle.atributo7,
ltbdetalle.atributo8,
ltbdetalle.atributo9,
ltbdetalle.atributo10,
ltbdetalle.atributo11,
ltbdetalle.atributo12,
ltbdetalle.atributo13,
ltbdetalle.atributo14,
ltbdetalle.atributo15,
ltbdetalle.attribute_category)
returning id_parrilla_det into linidnuevodetparrilla;
elsif (replace(ltbdetalle.des_hora_inicio, ':',''))::numeric  < 060000
and (replace(ltbdetalle.des_hora_fin, ':',''))::numeric  > 060000  then
linhorafinisonum := (oracle.substr(ltbdetalle.des_hora_fin, 1, 2))::numeric;
lsthorafinisoaux := oracle.substr(ltbdetalle.des_hora_fin, 1, 2);
linhorafinisonum := linhorafinisonum-1;
if linhorafinisonum < 10 then
lsthorafinaux := concat('0', to_char(linhorafinisonum));
else
lsthorafinaux := to_char(linhorafinisonum);
end if;
lsthorafiniso := concat(lsthorafinaux,
oracle.substr(ltbdetalle.des_hora_fin, 3));
if lsthorafiniso = '24:00:00' then
lsthorafiniso := '00:00:00';
end if;
insert into  admp.admp_parrilla_det_tab(id_parrilla_det,
id_parrilla,
id_genero,
des_ciclo,
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
attribute_category)
values (-1 ,
linidnuevoparrilla,
ltbdetalle.id_genero,
ltbdetalle.des_ciclo ,
'06:00:00',
ltbdetalle.des_hora_fin,
'06:00:00',
ltbdetalle.des_hora_fin,
'05:00:00',
lsthorafiniso,
ltbdetalle.id_tipo,
ltbdetalle.des_programa,
ltbdetalle.des_programa_original,
ltbdetalle.id_clasificacion,
ltbdetalle.id_formato,
ltbdetalle.id_restriccion,
ltbdetalle.des_notas,
ltbdetalle.num_transmisiones,
ltbdetalle.fec_ultima_transmision,
ltbdetalle.des_ultima_transmision,
ltbdetalle.num_color,
ltbdetalle.num_sap,
ltbdetalle.num_temporada,
ltbdetalle.num_repeticion_temp,
ltbdetalle.cod_programa_ibope,
ltbdetalle.des_programa_ibope,
ltbdetalle.id_fuente,
ltbdetalle.id_evento,
ltbdetalle.des_descripcion,
ltbdetalle.num_fuente_xls,
ltbdetalle.num_cambio_prog,
ltbdetalle.fec_cambio_prog,
ltbdetalle.des_capitulo,
piinidusuario,
clock_timestamp(),
piinidusuario,
clock_timestamp(),
piinidusuario,
ltbdetalle.atributo1,
ltbdetalle.atributo2,
ltbdetalle.atributo3,
ltbdetalle.atributo4,
ltbdetalle.atributo5,
ltbdetalle.atributo6,
ltbdetalle.atributo7,
ltbdetalle.atributo8,
ltbdetalle.atributo9,
ltbdetalle.atributo10,
ltbdetalle.atributo11,
ltbdetalle.atributo12,
ltbdetalle.atributo13,
ltbdetalle.atributo14,
ltbdetalle.atributo15,
ltbdetalle.attribute_category
)
returning id_parrilla_det into linidnuevodetparrilla;
elsif (replace(ltbdetalle.des_hora_inicio, ':',''))::numeric  >= 060000 then
linhorainiiso := (oracle.substr(ltbdetalle.des_hora_inicio, 1, 2))::numeric;
lsthorainicioisoaux := oracle.substr(ltbdetalle.des_hora_inicio, 1, 2);
linhorainiiso := linhorainiiso -1;
if linhorainiiso < 10 then
lsthorainicioaux := concat('0', to_char(linhorainiiso));
else
lsthorainicioaux := to_char(linhorainiiso);
end if;
lsthorainicioiso := concat(lsthorainicioaux,
oracle.substr(ltbdetalle.des_hora_inicio, 3));
linhorafinisonum := (oracle.substr(ltbdetalle.des_hora_fin, 1, 2))::numeric;
lsthorafinisoaux := oracle.substr(ltbdetalle.des_hora_fin, 1, 2);
linhorafinisonum := linhorafinisonum-1;
if linhorafinisonum < 10 then
lsthorafinaux := concat('0', to_char(linhorafinisonum));
else
lsthorafinaux := to_char(linhorafinisonum);
end if;
lsthorafiniso := concat(lsthorafinaux,
oracle.substr(ltbdetalle.des_hora_fin, 3));
if lsthorafiniso = '24:00:00' then
lsthorafiniso := '00:00:00';
end if;
insert into  admp.admp_parrilla_det_tab(id_parrilla_det,
id_parrilla,
id_genero,
des_ciclo,
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
attribute_category)
values (-1 ,
linidnuevoparrilla,
ltbdetalle.id_genero,
ltbdetalle.des_ciclo ,
ltbdetalle.des_hora_inicio,
ltbdetalle.des_hora_fin,
ltbdetalle.des_hora_inicio,
ltbdetalle.des_hora_fin,
lsthorainicioiso,
lsthorafiniso,
ltbdetalle.id_tipo,
ltbdetalle.des_programa,
ltbdetalle.des_programa_original,
ltbdetalle.id_clasificacion,
ltbdetalle.id_formato,
ltbdetalle.id_restriccion,
ltbdetalle.des_notas,
ltbdetalle.num_transmisiones,
ltbdetalle.fec_ultima_transmision,
ltbdetalle.des_ultima_transmision,
ltbdetalle.num_color,
ltbdetalle.num_sap,
ltbdetalle.num_temporada,
ltbdetalle.num_repeticion_temp,
ltbdetalle.cod_programa_ibope,
ltbdetalle.des_programa_ibope,
ltbdetalle.id_fuente,
ltbdetalle.id_evento,
ltbdetalle.des_descripcion,
ltbdetalle.num_fuente_xls,
ltbdetalle.num_cambio_prog,
ltbdetalle.fec_cambio_prog,
ltbdetalle.des_capitulo,
piinidusuario,
clock_timestamp(),
piinidusuario,
clock_timestamp(),
piinidusuario,
ltbdetalle.atributo1,
ltbdetalle.atributo2,
ltbdetalle.atributo3,
ltbdetalle.atributo4,
ltbdetalle.atributo5,
ltbdetalle.atributo6,
ltbdetalle.atributo7,
ltbdetalle.atributo8,
ltbdetalle.atributo9,
ltbdetalle.atributo10,
ltbdetalle.atributo11,
ltbdetalle.atributo12,
ltbdetalle.atributo13,
ltbdetalle.atributo14,
ltbdetalle.atributo15,
ltbdetalle.attribute_category)
returning id_parrilla_det into linidnuevodetparrilla;
end if;
end if;
end loop;
end if;
ldtfechaintervalo := ldtfechaintervalo + 1;
linintervalo := linintervalo - 1;
exit;
end loop;
close lcurcabecero;
close lcurcabecerosiguiente;
if linintervalo < 0 then
exit;
end if;
end;
end loop;
end;
elsif pistidaccion = 'S' then
declare
linintervalo numeric := 0;
ldtfechaintervalo timestamp(0) := to_timestamp(pistfechainidestino,'dd/mm/yyyy');
ldtfechainicio timestamp(0) := to_timestamp(pistfechainiorigen,'dd/mm/yyyy');
linidnuevoparrilla numeric :=-1;
linidnuevoparrillasig numeric :=-1;
linidnuevodetparrilla numeric :=-1;
linidparrillaorigen numeric :=0;
begin
for ltbrec in (
select  id_parrilla_det
from (
select * from admp.admp_parrilla_copia_vw
where   id_canal = piinidcanaldestino
and     fec_parrilla
between to_timestamp(pistfechainidestino,'dd/mm/yyyy')
and     to_timestamp(pistfechafindestino,'dd/mm/yyyy')
and     id_tipo_parrilla = piinidtipoparrilladestino
and     des_hora_fin <= '24:00:00'
union
select * from admp.admp_parrilla_copia_vw
where   id_canal = piinidcanaldestino
and     fec_parrilla
between(to_timestamp(pistfechainidestino,'dd/mm/yyyy')-1)
and     to_timestamp(pistfechafindestino,'dd/mm/yyyy')
and     id_tipo_parrilla = piinidtipoparrilladestino
and     des_hora_inicio < '24:00:00'
and     des_hora_fin > '24:00:00'
union
select * from admp.admp_parrilla_copia_vw
where   id_canal = piinidcanaldestino
and     fec_parrilla
between(to_timestamp(pistfechainidestino,'dd/mm/yyyy')-1)
and (to_timestamp(pistfechafindestino,'dd/mm/yyyy')-1)
and     id_tipo_parrilla = piinidtipoparrilladestino
and     des_hora_inicio >= '24:00:00') alias9)
loop
delete from admp.admp_target_parr_det_tab
where id_parrilla_det = ltbrec.id_parrilla_det;
delete from admp.admp_parrilla_det_tab
where id_parrilla_det = ltbrec.id_parrilla_det;
end loop;
select dmap_interval_to_days(to_timestamp(pistfechafinorigen,'dd/mm/yyyy')
- to_timestamp(pistfechainiorigen,'dd/mm/yyyy'))
into strict linintervalo;
loop
begin
select id_parrilla into strict linidparrillaorigen
from admp.admp_parrilla_tab
where fec_parrilla = ldtfechainicio
and id_canal = piinidcanalorigen
and id_tipo_parrilla = piinidtipoparrilla;
exception
when no_data_found then
linidparrillaorigen := null;
end;
declare
ltbcab   admp.admp_parrilla_tab%rowtype;
ltbnext  admp.admp_parrilla_tab%rowtype;
lsthorainiciotmp varchar(8) :=-1;
lsthorafintmp varchar(8) :=-1;
lsthorainicioiso varchar(8) :=-1;
lsthorafiniso varchar(8) :=-1;
lsthorafinaux varchar(8) :=-1;
lsthorafinisoaux varchar(8) :=-1;
linhorafinisonum numeric := -1;
lsthorainicioaux varchar(8) :=-1;
lsthorainicioisoaux varchar(8) :=-1;
linhorainiiso numeric := 0;
lcurcabecero cursor  for
select * from admp.admp_parrilla_tab
where fec_parrilla = ldtfechaintervalo
and id_canal = piinidcanaldestino
and id_tipo_parrilla = piinidtipoparrilladestino;
lcurcabecerosiguiente cursor  for
select * from admp.admp_parrilla_tab
where fec_parrilla = (ldtfechaintervalo - 1)
and id_canal = piinidcanaldestino
and id_tipo_parrilla = piinidtipoparrilladestino;
begin
open lcurcabecero;
open lcurcabecerosiguiente;
loop
fetch lcurcabecero into ltbcab;
flg0 := found;
flg1 := found;
flg2 := found;
flg3 := found;
fetch lcurcabecerosiguiente into ltbnext;
if not found then
if nullif(linidparrillaorigen::text, '') is not null then
insert into admp.admp_parrilla_tab(
id_parrilla,
fec_parrilla,
id_canal,
num_version,
id_estado,
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
attribute_category,
id_tipo_parrilla
)
values (
-1 ,
ldtfechaintervalo,
piinidcanaldestino,
1,
1,
piinidusuario,
clock_timestamp(),
piinidusuario,
clock_timestamp(),
piinidusuario,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
piinidtipoparrilladestino
)
returning id_parrilla into linidnuevoparrilla;
end if;
else
linidnuevoparrilla := ltbcab.id_parrilla;
end if;
if not found then
if nullif(linidparrillaorigen::text, '') is not null then
insert into admp.admp_parrilla_tab(
id_parrilla,
fec_parrilla,
id_canal,
num_version,
id_estado,
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
attribute_category,
id_tipo_parrilla
)
values (
-1 ,
(ldtfechaintervalo - 1),
piinidcanaldestino,
1,
1,
piinidusuario,
clock_timestamp(),
piinidusuario,
clock_timestamp(),
piinidusuario,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
null,
piinidtipoparrilladestino
)
returning id_parrilla into linidnuevoparrillasig;
end if;
else
linidnuevoparrillasig := ltbnext.id_parrilla;
end if;
if nullif(linidparrillaorigen::text, '') is not null then
for ltbdetalle in (
select  id_parrilla_det,
id_parrilla,
id_genero,
des_ciclo,
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
from    admp.admp_parrilla_det_tab
where   id_parrilla = linidparrillaorigen
)
loop
if (replace(ltbdetalle.des_hora_fin, ':',''))::numeric  <= 10000 then
if oracle.substr(ltbdetalle.des_hora_inicio, 1, 2) = '00' then
lsthorainiciotmp := concat('24',
oracle.substr(ltbdetalle.des_hora_inicio, 3));
lsthorainicioiso := concat('23',
oracle.substr(ltbdetalle.des_hora_inicio, 3));
elsif oracle.substr(ltbdetalle.des_hora_inicio, 1, 2) = '01' then
lsthorainiciotmp := concat('25',
oracle.substr(ltbdetalle.des_hora_inicio, 3));
lsthorainicioiso := concat('00',
oracle.substr(ltbdetalle.des_hora_inicio, 3));
end if;
if oracle.substr(ltbdetalle.des_hora_fin, 1, 2) = '00' then
lsthorafintmp := concat('24', oracle.substr(ltbdetalle.des_hora_fin, 3));
lsthorafiniso := concat('23', oracle.substr(ltbdetalle.des_hora_fin, 3));
elsif oracle.substr(ltbdetalle.des_hora_fin, 1, 2) = '01' then
lsthorafintmp := concat('25', oracle.substr(ltbdetalle.des_hora_fin, 3));
lsthorafiniso := concat('00', oracle.substr(ltbdetalle.des_hora_fin, 3));
end if;
insert into  admp.admp_parrilla_det_tab(
id_parrilla_det,
id_parrilla,
id_genero,
des_ciclo,
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
linidnuevoparrillasig,
ltbdetalle.id_genero,
ltbdetalle.des_ciclo ,
lsthorainiciotmp,
lsthorafintmp,
lsthorainiciotmp,
lsthorafintmp,
lsthorainicioiso,
lsthorafiniso,
ltbdetalle.id_tipo,
ltbdetalle.des_programa,
ltbdetalle.des_programa_original,
ltbdetalle.id_clasificacion,
ltbdetalle.id_formato,
ltbdetalle.id_restriccion,
ltbdetalle.des_notas,
ltbdetalle.num_transmisiones,
ltbdetalle.fec_ultima_transmision,
ltbdetalle.des_ultima_transmision,
ltbdetalle.num_color,
ltbdetalle.num_sap,
ltbdetalle.num_temporada,
ltbdetalle.num_repeticion_temp,
ltbdetalle.cod_programa_ibope,
ltbdetalle.des_programa_ibope,
ltbdetalle.id_fuente,
ltbdetalle.id_evento,
ltbdetalle.des_descripcion,
ltbdetalle.num_fuente_xls,
ltbdetalle.num_cambio_prog,
ltbdetalle.fec_cambio_prog,
ltbdetalle.des_capitulo,
piinidusuario,
clock_timestamp(),
piinidusuario,
clock_timestamp(),
piinidusuario,
ltbdetalle.atributo1,
ltbdetalle.atributo2,
ltbdetalle.atributo3,
ltbdetalle.atributo4,
ltbdetalle.atributo5,
ltbdetalle.atributo6,
ltbdetalle.atributo7,
ltbdetalle.atributo8,
ltbdetalle.atributo9,
ltbdetalle.atributo10,
ltbdetalle.atributo11,
ltbdetalle.atributo12,
ltbdetalle.atributo13,
ltbdetalle.atributo14,
ltbdetalle.atributo15,
ltbdetalle.attribute_category
)
returning id_parrilla_det into linidnuevodetparrilla;
elsif (replace(ltbdetalle.des_hora_inicio, ':',''))::numeric  < 060000
and (replace(ltbdetalle.des_hora_fin, ':',''))::numeric  > 060000  then
linhorafinisonum := (oracle.substr(ltbdetalle.des_hora_fin, 1, 2))::numeric;
lsthorafinisoaux := oracle.substr(ltbdetalle.des_hora_fin, 1, 2);
linhorafinisonum := linhorafinisonum-1;
if linhorafinisonum < 10 then
lsthorafinaux := concat('0', to_char(linhorafinisonum));
else
lsthorafinaux := to_char(linhorafinisonum);
end if;
lsthorafiniso := concat(lsthorafinaux,
oracle.substr(ltbdetalle.des_hora_fin, 3));
if lsthorafiniso = '24:00:00' then
lsthorafiniso := '00:00:00';
end if;
insert into  admp.admp_parrilla_det_tab(
id_parrilla_det,
id_parrilla,
id_genero,
des_ciclo,
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
linidnuevoparrilla,
ltbdetalle.id_genero,
ltbdetalle.des_ciclo ,
'06:00:00',
ltbdetalle.des_hora_fin,
'06:00:00',
ltbdetalle.des_hora_fin,
'05:00:00',
lsthorafiniso,
ltbdetalle.id_tipo,
ltbdetalle.des_programa,
ltbdetalle.des_programa_original,
ltbdetalle.id_clasificacion,
ltbdetalle.id_formato,
ltbdetalle.id_restriccion,
ltbdetalle.des_notas,
ltbdetalle.num_transmisiones,
ltbdetalle.fec_ultima_transmision,
ltbdetalle.des_ultima_transmision,
ltbdetalle.num_color,
ltbdetalle.num_sap,
ltbdetalle.num_temporada,
ltbdetalle.num_repeticion_temp,
ltbdetalle.cod_programa_ibope,
ltbdetalle.des_programa_ibope,
ltbdetalle.id_fuente,
ltbdetalle.id_evento,
ltbdetalle.des_descripcion,
ltbdetalle.num_fuente_xls,
ltbdetalle.num_cambio_prog,
ltbdetalle.fec_cambio_prog,
ltbdetalle.des_capitulo,
piinidusuario,
clock_timestamp(),
piinidusuario,
clock_timestamp(),
piinidusuario,
ltbdetalle.atributo1,
ltbdetalle.atributo2,
ltbdetalle.atributo3,
ltbdetalle.atributo4,
ltbdetalle.atributo5,
ltbdetalle.atributo6,
ltbdetalle.atributo7,
ltbdetalle.atributo8,
ltbdetalle.atributo9,
ltbdetalle.atributo10,
ltbdetalle.atributo11,
ltbdetalle.atributo12,
ltbdetalle.atributo13,
ltbdetalle.atributo14,
ltbdetalle.atributo15,
ltbdetalle.attribute_category
)
returning id_parrilla_det into linidnuevodetparrilla;
elsif (replace(ltbdetalle.des_hora_inicio, ':',''))::numeric  >= 060000 then
linhorainiiso := (oracle.substr(ltbdetalle.des_hora_inicio, 1, 2))::numeric;
lsthorainicioisoaux := oracle.substr(ltbdetalle.des_hora_inicio, 1, 2);
linhorainiiso := linhorainiiso -1;
if linhorainiiso < 10 then
lsthorainicioaux := concat('0', to_char(linhorainiiso));
else
lsthorainicioaux := to_char(linhorainiiso);
end if;
lsthorainicioiso := concat(lsthorainicioaux,
oracle.substr(ltbdetalle.des_hora_inicio, 3));
linhorafinisonum := (oracle.substr(ltbdetalle.des_hora_fin, 1, 2))::numeric;
lsthorafinisoaux := oracle.substr(ltbdetalle.des_hora_fin, 1, 2);
linhorafinisonum := linhorafinisonum-1;
if linhorafinisonum < 10 then
lsthorafinaux := concat('0', to_char(linhorafinisonum));
else
lsthorafinaux := to_char(linhorafinisonum);
end if;
lsthorafiniso := concat(lsthorafinaux,
oracle.substr(ltbdetalle.des_hora_fin, 3));
if lsthorafiniso = '24:00:00' then
lsthorafiniso := '00:00:00';
end if;
insert into  admp.admp_parrilla_det_tab(
id_parrilla_det,
id_parrilla,
id_genero,
des_ciclo,
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
linidnuevoparrilla,
ltbdetalle.id_genero,
ltbdetalle.des_ciclo,
ltbdetalle.des_hora_inicio,
ltbdetalle.des_hora_fin,
ltbdetalle.des_hora_inicio,
ltbdetalle.des_hora_fin,
lsthorainicioiso,
lsthorafiniso,
ltbdetalle.id_tipo,
ltbdetalle.des_programa,
ltbdetalle.des_programa_original,
ltbdetalle.id_clasificacion,
ltbdetalle.id_formato,
ltbdetalle.id_restriccion,
ltbdetalle.des_notas,
ltbdetalle.num_transmisiones,
ltbdetalle.fec_ultima_transmision,
ltbdetalle.des_ultima_transmision,
ltbdetalle.num_color,
ltbdetalle.num_sap,
ltbdetalle.num_temporada,
ltbdetalle.num_repeticion_temp,
ltbdetalle.cod_programa_ibope,
ltbdetalle.des_programa_ibope,
ltbdetalle.id_fuente,
ltbdetalle.id_evento,
ltbdetalle.des_descripcion,
ltbdetalle.num_fuente_xls,
ltbdetalle.num_cambio_prog,
ltbdetalle.fec_cambio_prog,
ltbdetalle.des_capitulo,
piinidusuario,
clock_timestamp(),
piinidusuario,
clock_timestamp(),
piinidusuario,
ltbdetalle.atributo1,
ltbdetalle.atributo2,
ltbdetalle.atributo3,
ltbdetalle.atributo4,
ltbdetalle.atributo5,
ltbdetalle.atributo6,
ltbdetalle.atributo7,
ltbdetalle.atributo8,
ltbdetalle.atributo9,
ltbdetalle.atributo10,
ltbdetalle.atributo11,
ltbdetalle.atributo12,
ltbdetalle.atributo13,
ltbdetalle.atributo14,
ltbdetalle.atributo15,
ltbdetalle.attribute_category
)
returning id_parrilla_det into linidnuevodetparrilla;
end if;
end loop;
end if;
ldtfechaintervalo := ldtfechaintervalo + 1;
ldtfechainicio := ldtfechainicio + 1;
linintervalo := linintervalo - 1;
exit;
end loop;
close lcurcabecero;
close lcurcabecerosiguiente;
if linintervalo < 0 then
exit;
end if;
end;
end loop;
end;
end if;
/* commit; */
postmensaje := 'ok';
exception
when others then
rollback;/* dmap converted statement start */
raise exception '%',  concat('An error was encountered - ', sqlstate, ' -ERROR- ', sqlerrm)  using errcode = '45001';/* dmap converted statement end */
end;
$body$
language plpgsql
;
