create or replace procedure fecxc.fecxp_segmentos_consolidados_fecxp_copia_monedas_set () as $body$
declare
-- pgv moved types start
-- pgv moved types end
recorre_cursor numeric;
c_emp_set cursor for select mon_sybase, mon_oracle, des_sybase,des_oracle, mon_set, tipo_cambio, fec_ingreso, mes, periodo,
des_set, atributo1, fecha_actualizacion
from fecxc.fecxp_monedas;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
delete from fecxc.fecxp_monedas_no_set where tipo_empresa='SET';
/* commit; */
for recorre_cursor in c_emp_set loop
begin
insert into fecxc.fecxp_monedas_no_set( mon_sybase, mon_oracle, des_sybase, des_oracle, mon_set, tipo_cambio, fec_ingreso, mes, periodo,
des_set, atributo1, fecha_actualizacion, tipo_empresa)
values (recorre_cursor.mon_sybase, recorre_cursor.mon_oracle,recorre_cursor.des_sybase,recorre_cursor.des_oracle,recorre_cursor.mon_set,recorre_cursor.tipo_cambio,recorre_cursor.fec_ingreso,recorre_cursor.mes,recorre_cursor.periodo,
recorre_cursor.des_set, recorre_cursor.atributo1,recorre_cursor.fecha_actualizacion,'SET');
exception
when others then
update fecxc.fecxp_monedas_no_set
set mon_sybase = recorre_cursor.mon_sybase,
mon_oracle = recorre_cursor.mon_oracle,
des_sybase = recorre_cursor.des_sybase,
des_oracle = recorre_cursor.des_oracle,
mon_set    = recorre_cursor.mon_set,
tipo_cambio= recorre_cursor.tipo_cambio,
fec_ingreso= recorre_cursor.fec_ingreso,
mes        = recorre_cursor.mes,
periodo    = recorre_cursor.periodo,
des_set    = recorre_cursor.des_set,
atributo1  = recorre_cursor.atributo1,
fecha_actualizacion = recorre_cursor.fecha_actualizacion,
tipo_empresa = 'NO SET'
where  mon_sybase = recorre_cursor.mon_sybase
and    mon_oracle = recorre_cursor.mon_oracle
and    mon_set = recorre_cursor.mon_set
and    periodo = recorre_cursor.periodo
and    mes     = recorre_cursor.mes;
end;
end loop;
/* commit; */
end;
$body$
language plpgsql
;
