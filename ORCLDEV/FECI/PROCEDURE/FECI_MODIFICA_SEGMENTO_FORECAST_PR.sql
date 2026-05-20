create or replace procedure feci."feci_modifica_segmento_forecast_pr"  ( p_id_segmento numeric, p_codigo varchar, p_descripcion varchar, p_moneda varchar, p_ind_cps numeric, p_ind_pais numeric, p_grupo_forecast varchar, p_usuario numeric, p_respuesta inout numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
respuesta           numeric := 0;
respuesta_des       numeric := 0;
valida              numeric := 0;
begin
select count(id_segmento) into strict valida  from feci_segmento_cat
where  cod_segmento = p_codigo and  des_segmento = p_descripcion and
id_segmento <> p_id_segmento;
if valida = 0 then
-- modifica en feci_segmento_cat
update feci_segmento_cat set
des_segmento = p_descripcion,
cod_moneda = p_moneda,
ind_cps = p_ind_cps,
ind_pais = p_ind_pais,
fec_ult_modificacion = clock_timestamp(),
id_usuario_ult_modif = p_usuario
where id_segmento = p_id_segmento;
update feci_grfc_segm_cat set
ind_estado = 0,
fec_ult_modificacion = clock_timestamp(),
id_usuario_ult_modif = p_usuario
where id_segmento = p_id_segmento;
if p_grupo_forecast <> ' ' then
-- procesar el array
for i in 1..regexp_count(p_grupo_forecast, ',') + 1 loop
begin
-- intentar insertar en feci_grfc_segm_cat
insert into feci_grfc_segm_cat(
id_segmento, id_grupo_forecast, fec_creacion, fec_ult_modificacion, id_usuario_creacion,
id_usuario_ult_modif, ind_estado
)
values (
p_id_segmento, regexp_substr(p_grupo_forecast, '[^,]+', 1, i), clock_timestamp(), clock_timestamp(), p_usuario, 0, 1
);
end;
end loop;
end if;
respuesta := p_id_segmento;
else
respuesta := -96; -- existe en otro id
end if;
p_respuesta := respuesta;end;
$body$
language plpgsql
;
