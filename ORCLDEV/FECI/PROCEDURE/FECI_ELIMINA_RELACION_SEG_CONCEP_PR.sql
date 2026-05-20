create or replace procedure feci."feci_elimina_relacion_seg_concep_pr"  ( p_id_segmento numeric, p_forecast numeric, p_conceptos varchar, p_usuario numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
update feci_segm_conc_cat set
ind_estado = 0
where  id_segmento =  p_id_segmento
and id_grupo_forecast = p_forecast;
if p_conceptos <> ' ' then
-- procesar el array
for i in 1..regexp_count(p_conceptos, ',') + 1 loop
begin
-- intentar insertar en feci_grfc_segm_cat
insert into feci_segm_conc_cat(
id_segmento, id_grupo_forecast, id_concepto,fec_creacion, fec_ult_modificacion, id_usuario_creacion,
id_usuario_ult_modif, ind_estado
)
values (
p_id_segmento,p_forecast, regexp_substr(p_conceptos, '[^,]+', 1, i), clock_timestamp(), clock_timestamp(), p_usuario, 0, 1
);
end;
end loop;
end if;end;
$body$
language plpgsql
;
