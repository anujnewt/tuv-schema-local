create or replace procedure feci."feci_modifica_concepto_region_pr"  ( p_id_concepto numeric, p_codigo varchar, p_descripcion varchar, p_regiones varchar, p_usuario numeric, p_respuesta inout numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
contador_clas        numeric := 0;
contador_pres       numeric := 0;
respuesta           numeric := 0;
concepto_id         numeric := 0;
valida              numeric := 0;
begin
select count(id_concepto) into strict valida from feci_concepto_cat
where  des_concepto = p_descripcion and id_concepto <>  p_id_concepto;
if valida = 0 then
-- insertar en feci_concepto_cat
update  feci_concepto_cat set
des_concepto = p_descripcion,
fec_ult_modificacion = clock_timestamp(),
id_usuario_ult_modif = p_usuario
where  id_concepto = p_id_concepto
returning id_concepto into concepto_id;
update  feci_regn_conc_cat set
ind_estado = 0
where id_concepto = concepto_id;
-- procesar el array
if p_regiones <> ' ' then
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
respuesta := -96; -- ya esta registrada la descripcion el concepto
end if;
p_respuesta := respuesta;end;
$body$
language plpgsql
;
