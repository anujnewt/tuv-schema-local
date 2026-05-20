create or replace procedure feci."feci_inserta_segmento_forecast_pr"  ( p_codigo varchar, p_descripcion varchar, p_moneda varchar, p_ind_cps numeric, p_ind_pais numeric, p_grupo_forecast varchar, p_usuario numeric, p_respuesta inout numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
contador_seg        numeric := 0;
contador_pres       numeric := 0;
contador_est        numeric := 0;
respuesta           numeric := 0;
segmento_id         numeric := 0;
valida              numeric := 0;
begin
-- verificar si el segmento no existe en clasificaciones
select count(folio_recibo) into strict contador_seg from feci_clasificaciones_vw
where cod_segmento = p_codigo;
if contador_seg = 0 then
-- verificar si el segmento no existe en presupuestos
select count(id_presupuesto) into strict contador_pres from feci_presupuesto_tab
where cod_segmento = p_codigo;
if contador_pres = 0 then
-- verificar si el segmento no existe en estimaciones
select count(id_estimacion) into strict contador_est from feci_estimacion_tab
where cod_segmento = p_codigo;
if contador_est = 0 then
select count(id_segmento) into strict valida from feci_segmento_cat
where cod_segmento = p_codigo and des_segmento = p_descripcion;
if valida = 0 then
-- insertar en feci_segmento_cat
insert into feci_segmento_cat(
cod_segmento, des_segmento, cod_moneda, ind_cps,ind_pais, fec_creacion, fec_ult_modificacion, id_usuario_creacion, id_usuario_ult_modif, ind_estado
)
values (
p_codigo, p_descripcion, p_moneda, p_ind_cps, p_ind_pais,clock_timestamp(), clock_timestamp(), p_usuario, 0, 1
)
returning id_segmento into segmento_id;
-- procesar el array
for i in 1..regexp_count(p_grupo_forecast, ',') + 1 loop
begin
-- intentar insertar en feci_grfc_segm_cat
insert into feci_grfc_segm_cat(
id_segmento, id_grupo_forecast, fec_creacion, fec_ult_modificacion, id_usuario_creacion,
id_usuario_ult_modif, ind_estado
)
values (
segmento_id, regexp_substr(p_grupo_forecast, '[^,]+', 1, i), clock_timestamp(), clock_timestamp(), p_usuario, 0, 1
);
exception
when others then
null; -- puedes manejar la excepci?eg?n tus necesidades
end;
end loop;
respuesta := segmento_id;
else
respuesta := -96; -- ya esta registrado el segmento
end if;
else
respuesta := -97; -- existe en estimaciones
end if;
else
respuesta := -98; -- existe en presupuestos
end if;
else
respuesta := -99; -- existe en clasificaciones
end if;
p_respuesta := respuesta;end;
$body$
language plpgsql
;
