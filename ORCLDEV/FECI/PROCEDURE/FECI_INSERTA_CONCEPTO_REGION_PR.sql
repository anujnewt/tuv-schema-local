create or replace procedure feci."feci_inserta_concepto_region_pr"  ( p_codigo varchar, p_descripcion varchar, p_regiones varchar, p_usuario numeric, p_respuesta inout numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
contador_clas        numeric := 0;
contador_pres       numeric := 0;
respuesta           numeric := 0;
concepto_id         numeric := 0;
valida              numeric := 0;
begin
-- verificar si el concepto no existe en clasificaciones
select count(folio_recibo) into strict contador_clas from feci_clasificaciones_vw
where cod_concepto = p_codigo;
if contador_clas = 0 then
-- verificar si el segmento no existe en presupuestos
select count(id_presupuesto) into strict contador_pres from feci_presupuesto_tab
where cod_concepto = p_codigo;
if contador_pres = 0 then
select count(id_concepto) into strict valida from feci_concepto_cat
where cod_concepto = p_codigo and des_concepto = p_descripcion;
if valida = 0 then
-- insertar en feci_concepto_cat
insert into feci_concepto_cat(
cod_concepto, des_concepto, fec_creacion, fec_ult_modificacion, id_usuario_creacion, id_usuario_ult_modif, ind_estado
)
values (
p_codigo, p_descripcion, clock_timestamp(), clock_timestamp(), p_usuario, 0, 1
)
returning id_concepto into concepto_id;
if (p_regiones = not null) then
-- procesar el array
for i in 1..regexp_count(p_regiones, ',') + 1 loop
begin
-- intentar insertar en feci_regn_conc_cat
insert into feci_regn_conc_cat(
id_region, id_concepto, fec_creacion, fec_ult_modificacion, id_usuario_creacion,
id_usuario_ult_modif, ind_estado
)
values (
regexp_substr(p_regiones, '[^,]+', 1, i),concepto_id , clock_timestamp(), clock_timestamp(), p_usuario, 0, 1
);
end;
end loop;
end if;
respuesta := concepto_id;
else
respuesta := -96; -- ya esta registrado el concepto
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
