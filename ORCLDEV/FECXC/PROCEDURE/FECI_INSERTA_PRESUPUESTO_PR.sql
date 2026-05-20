create or replace procedure fecxc."feci_inserta_presupuesto_pr"  ( p_codigo_segmento varchar, p_codigo_concepto varchar, p_codigo_region varchar, p_condigo_moneda varchar , p_fecha_presupuesto timestamp(0), p_num_gestion numeric, p_num_importe numeric , p_usuario numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
registro numeric;
feci_cursors refcursor;
insert_necesario numeric := 0;
begin 

-- verificar si ya existe un registro con la fecha especificada
select count(*) into strict insert_necesario
from feci_presupuesto_tab
where fec_presupuesto = to_timestamp(to_char(p_fecha_presupuesto, 'YYYY-MM-DD'),'YYYY-MM-DD')
and cod_segmento = p_codigo_segmento
and cod_concepto = p_codigo_concepto
and cod_region = p_codigo_region;
if (insert_necesario=0) then
insert into feci_presupuesto_tab(cod_segmento,cod_concepto,cod_region,cod_moneda,fec_presupuesto,num_gestion,num_importe,
fec_creacion,fec_ult_modificacion,id_usuario_creacion,id_usuario_ult_modif,ind_estado)
values (
p_codigo_segmento,
p_codigo_concepto,
p_codigo_region,
p_condigo_moneda,
to_timestamp(to_char(p_fecha_presupuesto, 'YYYY-MM-DD'),'YYYY-MM-DD'),
p_num_gestion,
p_num_importe,
clock_timestamp(),
clock_timestamp(),
p_usuario,
0,
1
) returning id_presupuesto into registro;
end if;
open feci_cursors for
select id_presupuesto from feci_presupuesto_tab where id_presupuesto =  registro;
dbms_sql_return_result(feci_cursors);end;
$body$
language plpgsql
;
