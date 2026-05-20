create or replace  function  usrdrc.app_common_pkg_get_sociedades_accionistas_fn (pistidssociedades varchar ,piinindtipocelebra numeric ) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
pstsociedades    varchar(32000);
pstsociedad      varchar(32000);
pstidssociedades varchar(32000);
pinnumocurencias numeric;
pinnumocurrencia numeric;
pinidunico       numeric;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
pstidssociedades := pistidssociedades;
/*
begin
select  app_common_pkg_get_celebrado_entre_partes_fn(id_meta_row)
into    pstidssociedades
from    dercorp_metatbl_tab
where   1=1
and     id_meta_row = piinidmetarow
;
exception
when no_data_found then
pstidssociedades := 0;
end;
*/
/*
begin
select length(app_common_pkg_get_celebrado_entre_partes_fn(id_meta_row))
- length(replace(app_common_pkg_get_celebrado_entre_partes_fn(id_meta_row),,))
into    pinnumocurencias
from    dercorp_metatbl_tab
where   1=1
and     id_meta_row = piinidmetarow
;
dbms_output.put_line(total ocurrencias:||pinnumocurencias);
exception
when no_data_found then
null;
end;
*/
begin
select length(pistidssociedades) - length(replace(pistidssociedades, ',', ''))
into strict    pinnumocurencias
;/* dmap converted statement start */
perform dbms_output.put_line( concat('Total Ocurrencias:', pinnumocurencias)) ;/* dmap converted statement end */
/*
if pinnumocurencias > 5
then
pinnumocurencias := 5;
pstidssociedades := oracle.substr(pstidssociedades,1,instr(pstidssociedades,,, 1, 5) - 1);
dbms_output.put_line(pstidssociedades :||pstidssociedades);
end if;
*/
exception
when no_data_found then
null;
end;
for i in 1..pinnumocurencias
loop
select instr(pstidssociedades,',', 1, 1)
into strict   pinnumocurrencia
;/* dmap converted statement start */
perform dbms_output.put_line( concat('Num Ocurrencia: ', pinnumocurrencia)) ;/* dmap converted statement end */
select oracle.substr(pstidssociedades,1,pinnumocurrencia-1)
into strict   pinidunico
;/* dmap converted statement start */
perform dbms_output.put_line( concat('Id Unico: ', pinidunico)) ;/* dmap converted statement end */
select oracle.substr(pstidssociedades,pinnumocurrencia+1)
into strict   pstidssociedades
;/* dmap converted statement start */
perform dbms_output.put_line( concat('Id Restante: ', pstidssociedades)) ;/* dmap converted statement end */
if piinindtipocelebra = 1 then
begin
select nombre
into strict    pstsociedad
from   dercorp_cat_personas_total_tab
where  1=1
and    person_id in (pinidunico)
;
exception
when no_data_found then
pstsociedad:= null;
end;
else
begin
select  val_cat_val
into strict    pstsociedad
from    dercorp_add_campo_cat_val_tab
where   1=1
and     id_catalogo = 40
and     id_catalogo_valor in (pinidunico)
;
exception
when no_data_found then
pstsociedad:= null;
end;
end if;/* dmap converted statement start */
perform dbms_output.put_line( concat('Sociedad: ', pstsociedad)) ;/* dmap converted statement end *//* dmap converted statement start */
pstsociedades :=  concat(pstsociedades, chr(13), pstsociedad) ;/* dmap converted statement end */
end loop;
if piinindtipocelebra = 1 then
begin
select nombre
into strict    pstsociedad
from   dercorp_cat_personas_total_tab
where  1=1
and    person_id in (pstidssociedades)
;
exception
when no_data_found then
pstsociedad:= null;
end;
else
begin
select  val_cat_val
into strict    pstsociedad
from    dercorp_add_campo_cat_val_tab
where   1=1
and     id_catalogo = 40
and     id_catalogo_valor in (pstidssociedades)
;
exception
when no_data_found then
pstsociedad:= null;
end;
end if;/* dmap converted statement start */
perform dbms_output.put_line( concat('Sociedad: ', pstsociedad)) ;/* dmap converted statement end *//* dmap converted statement start */
pstsociedades :=  concat(pstsociedades, chr(13), pstsociedad) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('Sociedades: ', pstsociedades)) ;/* dmap converted statement end */
/*
if pinnumocurencias = 5
then
pstsociedades := pstsociedades ||  ...;
end if;
*/
return pstsociedades;end;
$body$
language plpgsql
;
