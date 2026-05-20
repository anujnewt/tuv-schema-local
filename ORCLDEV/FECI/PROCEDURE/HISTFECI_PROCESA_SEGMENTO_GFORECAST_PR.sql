create or replace procedure feci."histfeci_procesa_segmento_gforecast_pr"  () as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_id_segmento feci_segmento_cat.id_segmento%type;
v_id_grupo_forecast feci_grupo_forecast_cat.id_grupo_forecast%type;
contador numeric;
rec record;
begin
for rec in (select cod_segmento, des_segmento, cod_grupo_forecast, des_grupo_forecast
from histfeci_recibos_masivo_tab)
loop
-- verificar si el segmento ya existe
begin
select id_segmento into strict v_id_segmento
from feci_segmento_cat
where cod_segmento = rec.cod_segmento;
exception
when no_data_found then
v_id_segmento := null;
end;
if nullif(v_id_segmento::text, '') is null then
-- insertar el segmento si no existe
insert into feci_segmento_cat(cod_segmento, des_segmento,cod_moneda,ind_cps,fec_creacion,fec_ult_modificacion,id_usuario_creacion,
id_usuario_ult_modif,ind_estado,ind_pais)
values (rec.cod_segmento, rec.des_segmento,'MXN',1,clock_timestamp(),clock_timestamp(),0,0,1,1);
-- obtener el id del segmento reci?insertado
select id_segmento into strict v_id_segmento
from feci_segmento_cat
where trim(both cod_segmento) = trim(both rec.cod_segmento);
end if;
begin
select coalesce(id_grupo_forecast, null)
into strict v_id_grupo_forecast
from feci_grupo_forecast_cat
where cod_grupo_forecast = rec.cod_grupo_forecast and ind_estado = 1;
exception
when no_data_found then
v_id_segmento := null;
end;
if nullif(v_id_grupo_forecast::text, '') is null then
-- insertar el grupo forecast si no existe
insert into feci_grupo_forecast_cat(cod_grupo_forecast, des_grupo_forecast, fec_creacion, fec_ult_modificacion, id_usuario_creacion,
id_usuario_ult_modif, ind_estado)
values (rec.cod_grupo_forecast, rec.des_grupo_forecast, clock_timestamp(), clock_timestamp(), 0, 0, 1);
-- obtener el id del grupo forecast reci?insertado
select  coalesce(id_grupo_forecast, null) into strict v_id_grupo_forecast
from feci_grupo_forecast_cat
where cod_grupo_forecast = rec.cod_grupo_forecast;
end if;
-- verificar si el registro ya existe en feci_grfc_segm_cat
select count(*) into strict contador
from feci_grfc_segm_cat where id_segmento = v_id_segmento and id_grupo_forecast = v_id_grupo_forecast;
if (contador=0) then
-- insertar el registro en feci_grfc_segm_cat si no existe
insert into feci_grfc_segm_cat(id_segmento, id_grupo_forecast, fec_creacion, fec_ult_modificacion, id_usuario_creacion, id_usuario_ult_modif, ind_estado)
values (v_id_segmento, v_id_grupo_forecast, clock_timestamp(), clock_timestamp(), 0, 0, 1);
end if;
end loop;
/* commit; */
end;
$body$
language plpgsql
;
