create or replace procedure feci."histfeci_procesa_concepto_region_pr"  () as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_id_concepto feci_concepto_cat.id_concepto%type;
v_id_region feci_region_cat.id_region%type;
contador numeric;
rec record;
begin
for rec in (select cod_concepto, des_concepto, cod_region, des_region
from histfeci_recibos_masivo_tab)
loop
begin
if nullif(rec.cod_concepto::text, '') is null then
v_id_concepto := 0;
else
-- verificar si el concepto ya existe
select coalesce(id_concepto, null) into strict v_id_concepto
from feci_concepto_cat
where cod_concepto = trim(both rec.cod_concepto);
end if;
exception
when no_data_found then
v_id_concepto := null; -- asigna un valor nulo cuando no se encuentra ninguna fila
end;
if nullif(v_id_concepto::text, '') is null then
-- insertar el concepto si no existe
insert into feci_concepto_cat(cod_concepto, des_concepto,fec_creacion,fec_ult_modificacion,id_usuario_creacion,
id_usuario_ult_modif,ind_estado)
values (rec.cod_concepto, rec.des_concepto,clock_timestamp(),clock_timestamp(),0,0,1);
-- obtener el id del concepto recien insertado
select id_concepto into strict v_id_concepto
from feci_concepto_cat
where cod_concepto = rec.cod_concepto;
end if;
-- verificar si la region ya existe
begin
if nullif(rec.cod_region::text, '') is null then
v_id_region := 0;
else
select coalesce(id_region, null) into strict v_id_region
from feci_region_cat
where cod_region = trim(both rec.cod_region);
end if;
exception
when no_data_found then
v_id_region := null; -- asigna un valor nulo cuando no se encuentra ninguna fila
end;
if nullif(v_id_region::text, '') is null then
-- insertar la region si no existe
insert into feci_region_cat(cod_region, des_region,fec_creacion,fec_ult_modificacion,id_usuario_creacion,
id_usuario_ult_modif,ind_estado)
values (rec.cod_region, rec.des_region,clock_timestamp(),clock_timestamp(),0,0,1);
-- obtener el id de la region recien insertada
select id_region into strict v_id_region
from feci_region_cat
where cod_region = rec.cod_region;
end if;
if v_id_concepto >0 and v_id_region> 0 then
select count(*) into strict contador from feci_regn_conc_cat
where id_concepto = v_id_concepto and id_region = v_id_region;
-- verificar si el registro ya existe en feci_regn_conc_cat
if contador=0 then
-- insertar el registro en feci_regn_conc_cat si no existe
insert into feci_regn_conc_cat(id_concepto, id_region,fec_creacion,fec_ult_modificacion,id_usuario_creacion,
id_usuario_ult_modif,ind_estado)
values (v_id_concepto, v_id_region,clock_timestamp(),clock_timestamp(),0,0,1);
end if;
end if;
end loop;end;
$body$
language plpgsql
;
