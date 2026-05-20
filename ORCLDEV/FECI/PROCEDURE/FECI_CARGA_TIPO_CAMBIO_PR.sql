create or replace procedure feci."feci_carga_tipo_cambio_pr"  ( p_fecha varchar, p_de varchar, p_a varchar, p_tipo_cambio varchar, p_factor varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
insert into feci_carga_tipocambio_batch(fecha,de,a,tipo_cambio,factor)
values (p_fecha,p_de,p_a,p_tipo_cambio,p_factor);end;
$body$
language plpgsql
;
